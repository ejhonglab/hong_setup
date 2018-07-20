#!/usr/bin/env bash

# TODO create .ssh directory if not there? there already?

# TODO automatically fix permissions if there is an issue? assert we are not
# root?

# TODO currently assumes all users will be the same account across
# computers(?)...  fix that?

restrict="from=\"${client}.hong\",command=\"rsync --server -vlogDtprz .\""

# TODO check for the various env vars i've used, like DATA_DIR?
# TODO validate that local source is a directory (or warn if not?)
local_src_default="~/data"
remote_dest_default="~/data"
count=1
for host in "$@"
do
    if nc -z -w 10 ${host} 22 2>/dev/null; then
		echo "Remote host: $host"
        echo -n "${restrict}$(cat $key.pub)" | \
            ssh $host "grep -q \"(${client})\" || cat >> ~/.ssh/authorized_keys"

        num_string=""
        if [ "${count}" -gt "1" ]; then
            num_string="${num_string}${count}"
        fi
        count=$((count + 1))
        # TODO check if it's in bash_aliases / otherwise aliased & retry if so?
        alias_name_default="transfer_data${num_string}"
        alias_name=$(read -e -p "Alias name (${alias_name_default}):")
        alias_name=${alias_name:-${alias_name_default}}

        local_src=$(read -e -p "Local source path (${local_src_default}):")
        local_src=${local_src:-${local_src_default}}

        remote_dest=$(read -e \
            -p "Remote destination path (${remote_dest_default}):")
        remote_dest=${remote_dest:-${remote_dest_default}}

        # TODO TODO test the above

        a="alias ${alias_name}=\""
        # TODO single quotes work here, on inner expr?
        a="rsync -auvPz -e 'ssh -vi ~/.ssh/${key}'"
        a="${a} ${local_src} ${remote_dest}\""

        # TODO make aliases: transfer_data, transfer_data2, ...
        # transfer_data_all? backup?

        # TODO test remote paths exist?
		echo ""
    else
        echo "host $host not reachable. skipping."
    fi
done

