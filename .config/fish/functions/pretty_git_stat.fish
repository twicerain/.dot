function pretty_git_stat
    set -l CYAN (set_color cyan)
    set -l MAG (set_color magenta)
    set -l YEL (set_color yellow)
    set -l GRN (set_color green)
    set -l RED (set_color red)
    set -l NORM (set_color normal)

    # icon + branch
    printf '%s %s%s%s\n' $CYAN $MAG (git branch --show-current) $NORM

    # diff --stat with colours
    git -c color.ui=always diff --stat --color=always \
        | while read -l line
        if string match -qr '^\s*[0-9]+ files? changed' -- $line
            # summary line - color numbers
            set line (string replace -r '([0-9]+) (files?)' \
                "$YEL\$1$NORM \$2" -- $line)
            set line (string replace -r '([0-9]+) (insertions?)\((.)\)' \
                "$GRN\$1$NORM \$2 ($GRN\$3$NORM)" -- $line)
            set line (string replace -r '([0-9]+) (deletions?)\((.)\)' \
                "$RED\$1$NORM \$2 ($RED\$3$NORM)" -- $line)
        else
            # file line - colour path
            set line (string replace -r '([^|]+)\|' \
                "$YEL\$1$NORM|" -- $line)
        end

        printf '%s\n' $line
    end
end
