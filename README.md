# mastodon_cache_cleanup

This script is meant for the Docker Version of Mastodon.
Scripts for maintaining mastodon instance


Welcome to the mastodon_cache_cleanup wiki! Tested with version: 4.3.1

You should add one of the scripts to your mastodon directory.

The script will execute following cleanup commands as shown in the mastodon wiki: 
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl media remove 
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl preview_cards remove
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl media remove-orphans
/usr/local/bin/docker-compose run --rm web bundle exec bin/tootctl emoji purge --remote-only

Afterwards it will write it into a logfile called: cleanup_log.txt

For perfect use, create a cronjob like this:

This runs the Script once per Day at midnight. 
sudo crontab -e 

0 0 * * * cd /path_to_project/mastodon && ./cleanup.sh >> /path_to_project/mastodon/cleanuplog.txt 2>&1

The second version would be the cleanup_discord Script.

This is the exact same Script just with an added Discord Webhook to send you a notification, once the script is done. You will need a Discord Webhook for this one: https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks

Best reagards, Playerlist
