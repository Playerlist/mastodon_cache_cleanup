# mastodon_cache_cleanup
Scripts for maintaining mastodon instance


Welcome to the mastodon_cache_cleanup wiki! Tested with version: 4.3.1

You should add one of the scripts to your mastodon directory.

For perfect use, create a cronjob like this:

This runs the Script once per Day at midnight. 
sudo crontab -e 

0 0 * * * cd /path_to_project/mastodon && ./cleanup.sh >> /path_to_project/mastodon/cleanuplog.txt 2>&1

The second version would be the cleanup_discord Script.

This is the exact same Script just with an added Discord Webhook to send you a notification, once the script is done. You will need a Discord Webhook for this one: https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks

Best reagards, Playerlist
