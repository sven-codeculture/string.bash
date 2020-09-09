# @depends string_escape
string_replace()
{
    local type
    local search
    local replace
    local string

    if [[ "${1}" = '--type' ]] || [[ "${1}" = '-t' ]]; then
        type="${2}"
        shift 2
    else
        type="plain"
    fi

    if [[ -z "${1}" ]]; then
        return 1
    fi

    case "${type}" in
        plain)
            search=$(string_escape --type regex "${1}")
            replace=$(string_escape --type regex "${2}")
        ;;
        regex)
            search="${1}"
            replace="${2}"
        ;;
        *)
            return 2
        ;;
    esac

    if [[ -z "${3}" ]] && [ ! -t 0 ]; then
        string=$(cat <&0)
    else
        string="${3}"
    fi

    echo "${string}" | gsed -E "s/${search}/${replace}/g"
}
