function nr --desc "Fuzzy find, select, and run npm scripts found in repo."
    # forwarded args
    set -l npm_args
    if contains -- -- $argv
        set -l idx (contains -i -- $argv)
        set npm_args $argv[(math $idx + 2)..-1]
        set argv $argv[1..(math $idx - 1)]
    end

    # nr args
    argparse h/help l/list -- $argv
    or return

    # useage
    if set -q _flag_help
        printf "Useage: nr [options]  [-- npm_args]\n\n"
        printf "Fuzzy find, select, and run npm scripts found in repo.\n"
        printf "Options:\n"
        printf "  -l, --list    list scripts in repo\n"
        printf "  -h, --help    print usage\n"
        printf "  --            arguments passed to npm run\n"
        return 0
    end

    # git repo
    set -l root $(git rev-parse --show-toplevel)
    or return 1
    set -l repo (basename $root)

    # package.json
    set -l pkgs (fd --type file package.json --exclude node_modules $root)
    if test (count $pkgs) -eq 0
        echo "no package.json files in $repo" >&2
        return 1
    end

    # find scripts
    set -l scripts
    set -l idx 1
    for pkg in $pkgs
        set -l abs_dir (dirname "$pkg")
        set -l rel_dir (string replace -r "^$root/?(.*)" '$1' "$abs_dir")

        set -l name
        if test "$rel_dir" = ""
            set name (set_color -o normal)$repo
        else
            set -l base (dirname $rel_dir)
            if test "$base" = "."
                set base ""
            end
            set name "$(set_color -d)$repo/$base$(set_color -o normal)$(basename $rel_dir)"
        end

        for script in (jq -r '.scripts? | keys[]?' "$pkg")
            set scripts $scripts (set_color -d)"["$idx"] "$name(set_color normal)": "(set_color -o cyan)$script(set_color normal)
            set idx (math $idx + 1)
        end
    end

    if set -q _flag_list
        for script in $scripts
            printf "%s\n" $script
        end
        and return 0
    end

    set -l fzf_opts \
        --ansi \
        --multi \
        --layout=reverse-list \
        --info=inline \
        --border \
        --header-border \
        --header-first \
        --header="$(set_color cyan)$repo$(set_color normal): npm run scripts" \
        --margin=8% \
        --height=(math (count $scripts) + 7) \
        --prompt="$(set_color -d)<script>$(set_color -o blue) >  $(set_color normal)"

    set -l filter
    if test (count $argv) -gt 0
        set filter $argv[1]
    end

    set prompt --prompt="$(set_color -d)<script>$(set_color normal)$(set_color --bold brblue)  $(set_color normal)"
    set -l sels

    if test -n "$filter"
        set sels (printf "%s\n" $scripts | fzf $fzf_opts --filter="$filter" --select-1 --exit-0)
    end

    if test (count $sels) -ne 1
        if test (count $sels) -gt 1
            printf "nr: found multiple, select target scripts"
            set scripts $sels
        end
        set sels (printf "%s\n" $scripts | fzf $fzf_opts $prompt)
    end
    or echo "empty selection"; or return 0

    for sel in $sels
        set -l parts (string split ' | ' (string replace -r "\[(.*)\] (.*): (.*)" '$1 | $2 | $3' $sel))

        set -l idx $(printf "%d" $parts[1])
        set -l dir $parts[2]
        set -l script $parts[3]
        set -l base (dirname $root)

        printf "%s\n...\n" (string join ' ' (string split ' ' $scripts[$idx])[2..3])
        npm run -s $npm_args --prefix "$base/$dir" $script
        printf "\n"
    end
end
