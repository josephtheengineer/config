function main {
        encrypted=false
        drive=""
        path=""

        check $@

        mount "$drive" "$path" "$encrypted"

        echo $drive "and" $path
        exit 1
}

function check {
        local OPTIND opt
        while getopts ":ed:p:" opt; do
                case $opt in
                        e) encrypted=true;;
                        d) drive="$OPTARG";;
                        p) path="$OPTARG";;
                        \?h) help;exit 1;;
                esac
        done
        shift $((OPTIND -1))
}

