function dot
    if test (count $argv) -gt 0
        git --git-dir=$HOME/.dot --work-tree=$HOME $argv
    else
        git --git-dir=$HOME/.dot --work-tree=$HOME status
    end
end
