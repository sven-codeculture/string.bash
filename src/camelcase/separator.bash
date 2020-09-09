# @depends string_escape
string_camelcase_separator()
{
    local separator="${1}"
    local string="${2}"
    local pattern

    if [[ -z "${separator}" ]]; then
        return 1
    fi

    if [[ -z "${string}" ]] && [ ! -t 0 ]; then
        string=$(cat <&0)
    fi

    separator=$(string_escape --type regex "${1}" | gsed 's#/#\\/#g')
    pattern="s/([A-Za-z0-9])([A-Z])/\1${separator}\2/g"

    echo "${string}" | gsed -E "${pattern}" | gsed -E "${pattern}"
}
