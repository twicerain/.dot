function g
    if test -z "$argv"
        git status
    else
        git $argv
    end
end
