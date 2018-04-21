#!/usr/bin/env bash

# TODO create .ssh directory if not there? there already?

# TODO automatically fix permissions if there is an issue? assert we are not
# root?

# TODO currently assumes all users will be the same account across
# computers(?)...  fix that?

KEY=~/.ssh/id_rsync
# Test key (exists and is non-empty) and (is readable).
if [ -s "$KEY" ] && [ -r "$KEY" ]; then
    ssh-keygen -f $KEY -N "" \
        -C "automated data transfer (rsync) for analysis"
fi

RESTRICT="from=\"$(hostname).hong\",command=\"rsync --server -vlogDtprz .\""
for host in "$@"
do
    if nc -z -w 10 $host 22 2>/dev/null; then
        # TODO delete me
        echo "${RESTRICT}$(cat $KEY.pub)"
        #
        echo -n "${RESTRICT}$(cat $KEY.pub)" | \
            ssh $host 'cat >> ~/.ssh/authorized_keys'
    else
        echo "host $host not reachable. skipping."
    fi
done
