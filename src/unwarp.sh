#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# script_dir="$(dirname "${BASH_SOURCE[0]}")"
script_name="$(basename "${BASH_SOURCE[0]}")"
version='v0.2.0'

warp_bin="${UNWARP_WARP_BIN:-warp-cli}"
delay_secs="${UNWARP_DELAY_SECS:-1}"

function usage() {
    cat <<EOF
Usage: ${script_name} [-b] [-s] [-v] [-h]

Disables Cloudflare WARP client.

Options:
    -b      custom binary path for the \`warp-cli\`
            utility. (default: ${warp_bin})
    -s      interval to trigger the disconnect
            command, in secs. (default: ${delay_secs})
    -v      displays the build version.
    -h      displays this help message.
EOF
}

function version() {
    printf "%s %s\n" "${script_name}" "${version}"
}

# Parse optional flags
# NOTE: We use the preceeding colon to explicitly handle error messages
while getopts ':b:s:vh' opt; do
    case "${opt}" in
    b)
        warp_bin="${OPTARG}"
        ;;
    s)
        delay_secs="${OPTARG}"
        ;;
    v)
        version
        exit 0
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        err "-${OPTARG} is not a recognised option"
        usage
        exit 1
        ;;
    :)
        err "-${OPTARG} option requires a value"
        usage
        exit 1
        ;;
    esac
done
shift "$((OPTIND - 1))"

if ! command -v "${warp_bin}" &>/dev/null; then
    printf 'error: command %s is not found. ensure it is installed, executable, and added to PATH\n' "${warp_bin}" >&2
    exit 1
fi

while true; do
    "${warp_bin}" disconnect >/dev/null
    sleep "${delay_secs}"
done
