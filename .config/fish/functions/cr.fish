function cr --desc "clone a repo to ~/dev/<github-user>/<git-repo>"
    set -l repo_arg $argv[1]

    # Handle GitHub URLs (both HTTPS and SSH)
    if string match -q -r -- "(https://github.com/|git@github.com:)" $repo_arg
        # Extract owner/repo from HTTPS URL: https://github.com/owner/repo.git
        # or from SSH URL: git@github.com:owner/repo.git
        set -l repo_path (echo $repo_arg | sed -E 's/^(https:\/\/github\.com\/|git@github\.com:)([^\/]+)\/([^\/]+)(\.git)?$/\2\/\3/g')

        # Extract owner and repo from the path
        set -l owner (echo $repo_path | cut -d '/' -f 1)
        set -l repo (echo $repo_path | cut -d '/' -f 2 | sed 's/\.git$//')

        # Create directory if it doesn't exist
        mkdir -p ~/dev/$owner >/dev/null

        # Clone repository
        git clone -- $repo_arg ~/dev/$owner/$repo
        cd ~/dev/$owner/$repo
    else
        # Handle simple "owner/repo" format
        if string match -q -r -- / $repo_arg
            set -l owner (echo $repo_arg | cut -d '/' -f 1)
            set -l repo (echo $repo_arg | cut -d '/' -f 2)

            mkdir -p ~/dev/$owner >/dev/null
            gh repo clone $repo_arg ~/dev/$owner/$repo
            cd ~/dev/$owner/$repo
        else
            # Handle just "repo" format (uses current GitHub username)
            # More reliable way to get GitHub username
            set -l username (gh api user --jq '.login' 2>/dev/null)

            # Fallback if API call fails
            if test -z "$username"
                set username (gh auth status --hostname github.com 2>&1 | grep "Logged in" | sed -n 's/.*as \([^ ]*\).*/\1/p')
            end

            # Final fallback - hardcode your username
            if test -z "$username"
                set username twicerain
            end

            set -l repo $repo_arg

            mkdir -p ~/dev/$username
            cd ~/dev/$username
            gh repo clone $username/$repo
            cd $repo
        end
    end
end
