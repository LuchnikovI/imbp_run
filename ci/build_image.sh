#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

. "${script_dir}/utils.sh"


# ------------------------------------------------------------------------------------------

log INFO "Building an image ${IMBP_IMAGE_NAME}"
# https://github.com/moby/moby/issues/27393#
docker buildx build --tag "${IMBP_IMAGE_NAME}" -f - ${script_dir}/.. <<EOF

FROM ${IMBP_BASE_IMAGE}
WORKDIR /imbp_run
COPY . .
RUN groupadd -g ${IMBP_GID} ${IMBP_UNAME} && \
    useradd -m -u ${IMBP_UID} -g ${IMBP_GID} -s /bin/bash ${IMBP_UNAME} && \
    export DEBIAN_FRONTEND=noninteractive && \
    su - $(id -un ${IMBP_UID}) && \
    julia /imbp_run/ci/configure_pkgs.jl
EOF

if [[ $? -ne 0 ]];
then
    log ERROR "Failed to build a base image ${IMBP_IMAGE_NAME}"
    exit 1
else
    log INFO "Base image ${IMBP_IMAGE_NAME} has been built"
fi