#!/usr/bin/env bash

get_help() {
cat << EOF
Runs a particular experiment from `./experiments` directory

Usage: . ${BASH_SOURCE[0]} (help | <EXPERIMENT NAME>)
EOF
}

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
. "${script_dir}/utils.sh"
. "${script_dir}/ensure_image.sh"

docker_run="docker run \
    --user $IMBP_UID:$IMBP_GID
    --workdir "${script_dir}/.." \
    --mount type=bind,source="${HOME}",target="${HOME}" \
    ${IMBP_IMAGE_NAME}"

case $1 in

  help)
        get_help
        exit 0
    ;;
  *)
        ${docker_run} "${script_dir}/../experiments/$1.jl" $@
    ;;
esac