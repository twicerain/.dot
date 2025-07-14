# .dot

dotfiles bare repo.

## Usage

### Requirements

Requires only git:
```fish

paru -Syu git
```

### Setup

Clone the bare repo:
```fish
git clone --bare https://github.com/twicerain/.dot.git ~/.dot
```

Checkout files:
```fish
git --git-dir=$HOME/.dot --work-tree=$HOME checkout
```


### Tracking

All files are ignored by default, and added to untracked/tracked using the [.gitignore](.gitignore). This allows for easily adding changes to config files using [lazygit](.config/lazygit) or the [dot function](.config/fish/functions/dot.fish).


## Highlights

- [dot.fish](.config/fish/functions/dot.fish) & [lazydot](.config/fish/config.fish)
  - interact directly with dot files git repo regardless of cwd
- [nr.fish](.config/fish/functions/nr.fish)
  - fuzzy find through all npm scripts in the current git repo, select one or many to run them, or see usage with `nr -h`
- [toggle-decorations (`SUPER-d`)](.config/hypr/toggle-decorations.sh)
  - toggles hyprland animations, opacity, and blur
- [in.fish](.config/fish/functions/in.fish) & [re.fish](.config/fish/functions/re.fish)
  - fuzzy find and install or remove packages using paru
- [editor](.config/nvim)
  - nvim inspired by kickstart & lazyvim



