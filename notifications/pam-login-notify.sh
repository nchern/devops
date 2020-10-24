#!/bin/sh

# This script should be called by PAM to notify about ssh logins to the system
# It relies on preconfigured local MTA
# Source: http://askubuntu.com/questions/179889/how-do-i-set-up-an-email-alert-when-a-ssh-login-is-successful

TO="%EMAIL%"

HOST=$(hostname)

KNOWN_REMOTES_FILE="/home/$PAM_USER/.known_remotes"

if [ "$PAM_TYPE" != "close_session" ]; then
    if [ -f "$KNOWN_REMOTES_FILE" ] && grep -q "$PAM_RHOST" $KNOWN_REMOTES_FILE ; then
        # if we know this remote, don't send anything
    	exit 0
    fi

    SUBJECT="SSH Login[$HOST]: $PAM_USER from $PAM_RHOST"
    MESSAGE="Successful login using $PAM_SERVICE"

    echo "$MESSAGE" | mail -s "$SUBJECT" $TO
fi
