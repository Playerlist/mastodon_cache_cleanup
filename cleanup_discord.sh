#!/bin/bash

# Variables
LOG_FILE="cleanuplog.txt"
DISCORD_WEBHOOK="https://discord.com/api/webhooks/1313483110012158012/UN_zJp7jji57u1zkAUx6HWFgpI1y8GqXv3D6sI_oF2JiIS0PQo0F9uC2lb7gO3QD0p83"

# Log the current date and time
current_date_time=$(date)
echo "Current date and time: $current_date_time" >> "$LOG_FILE"

# Log and execute cleanup operations
echo "Cleaning up Mastodon cache" >> "$LOG_FILE"
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl media remove >> "$LOG_FILE" 2>&1
echo "Media cleanup done." >> "$LOG_FILE"

/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl preview_cards remove >> "$LOG_FILE" 2>&1
echo "Preview cards cleanup done." >> "$LOG_FILE"

/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl emoji purge --remote-only >> "$LOG_FILE" 2>&1
echo “Remote Emoji cleanup done." >> "$LOG_FILE"

/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl media remove-orphans >> "$LOG_FILE" 2>&1
echo “Media cache orphans cleanup done." >> "$LOG_FILE"

echo "Done cleaning up" >> "$LOG_FILE"

# Read the log file to prepare the Discord message
cleanup_results=$(tail -n 10 "$LOG_FILE")  # Fetch the last 10 lines for brevity

# Escape special characters and send the results to Discord
response=$(jq -n --arg content "Daily Cleanup complete. Cleanup Log:\`\`\`$cleanup_results\`\`\`" \
    '{"content":$content}' | \
    curl -s -X POST -H "Content-Type: application/json" \
    -d @- "$DISCORD_WEBHOOK")

# Debug API response
echo "Discord API response: $response" >> "$LOG_FILE"

# Check if the Discord post was successful
if [[ $response == *"\"id\":"* ]]; then
    echo "Cleanup results posted to Discord successfully." >> "$LOG_FILE"
else
    echo "Failed to post cleanup results to Discord: $response" >> "$LOG_FILE"
fi

