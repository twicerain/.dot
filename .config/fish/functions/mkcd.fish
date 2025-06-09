function mkcd
    if test -z "$argv"
        echo "Usage: mkcd <directory>"
    end
    mkdir -pv "$argv" && cd "$argv"
end
