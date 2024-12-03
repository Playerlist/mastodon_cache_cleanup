#!/bin/bash
current_date_time=$(date)
echo "Current date and time: $current_date_time" >> cleanuplog.txt
echo "Cleaning up mastodon cash" >> cleanuplog.txt
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl media remove >> cleanuplog.txt
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl preview_cards remove >> cleanuplog.txt
echo "Done cleaning up" >> cleanuplog.txt
