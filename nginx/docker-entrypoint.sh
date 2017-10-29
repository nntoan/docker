#!/bin/sh
set -e

if test $CHANGE_OWNER -gt 0
then                  
        ORIGPASSWD=$(cat /etc/passwd | grep $USERNAME)
        ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
        ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
                                                                                
        if [ \("$USER_ID" != "$ORIG_UID"\) -o \("$GROUP_ID" != "$ORIG_GID"\) ]; then
                sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$USER_ID:$GROUP_ID:/" /etc/passwd
                sed -i -e "s/$USERNAME:x:$ORIG_GID:/$USERNAME:x:$GROUP_ID:/" /etc/group          
                ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)                
                chown -R ${USER_ID}:${GROUP_ID} ${ORIG_HOME}
        fi                                                  
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- nginx "$@"
fi

exec "$@"
