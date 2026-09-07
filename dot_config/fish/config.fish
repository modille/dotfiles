if status is-interactive
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    # fish_config theme choose catppuccin-macchiato
    fish_config theme choose modille-solarized

    # https://github.com/wez/wezterm/issues/2781#issuecomment-1324143452
    set fish_vi_force_cursor 1

    abbr --add be "bundle exec"

    abbr --add claude "claude --model=claude-opus-4-8 --effort=high"

    abbr --add dc "docker compose"
    abbr --add dcd "docker compose down"
    abbr --add dcp "docker compose ps"
    abbr --add dcs "docker compose stop"
    abbr --add dcu "docker compose up --detach"

    abbr --add ga "git add"
    abbr --add gcane "git commit --amend --no-edit"
    abbr --add gcnv "git commit --no-verify"
    abbr --add gco "git checkout"
    abbr --add gd "git diff"
    abbr --add gdc "git diff --cached"
    abbr --add gds "git diff --staged"
    abbr --add gf "git fetch"
    abbr --add gfo "git fetch origin"
    abbr --add gfom "git fetch origin main:main"
    abbr --add gfp "git fetch --prune"
    abbr --add gpf "git push --force-with-lease"
    abbr --add gprp "git pull --rebase --prune"
    abbr --add gs "git status"
    abbr --add gsc "git switch --create"
    # scmpuff init --shell=fish --aliases=false | source
    # abbr --add gs scmpuff_status
    abbr --add gsi "git status --ignored"
    abbr --add gsw "git switch"
    abbr --add gsuir "git submodule update --init --recursive"

    abbr --add kc kubectl
    abbr --add kcd "kubectl --context=dev"
    abbr --add kcm "kubectl --context=demo"
    abbr --add kcp "kubectl --context=prd"
    abbr --add kcs "kubectl --context=stg"

    abbr --add lzd lazydocker

    abbr --add wip "git commit --no-verify -m 'WIP [skip ci]'"
    # abbr --add handoff "git add --all && git commit --amend --no-edit && git push --force-with-lease"

    # Initialize starship BEFORE sourcing the iTerm2 shell integration. The
    # integration wraps whatever fish_prompt/fish_mode_prompt exist when it's
    # sourced; if starship loads afterward it replaces the prompt and iTerm2's
    # per-prompt hook (iterm2_print_user_vars -> badges & user vars) never runs.
    starship init fish | source

    if test -e $HOME/.iterm2_shell_integration.fish
        source $HOME/.iterm2_shell_integration.fish
    end
    function iterm2_print_user_vars
        iterm2_set_user_var badge (dir_badges)
        iterm2_set_user_var gh_repo (gh_repo_slug)
    end
    # owner/repo slug of the current git repo, for iTerm2 PR-link triggers.
    # Prefer upstream (fork workflows), fall back to origin; empty outside a repo.
    function gh_repo_slug
        set -l url (git remote get-url upstream 2>/dev/null; or git remote get-url origin 2>/dev/null)
        test -n "$url"; or return
        string replace -r '^(git@[^:]+:|https?://[^/]+/)' '' -- $url | string replace -r '\.git$' ''
    end
    function dir_badges
        while read directory badge
            # Safely expand $HOME in the directory string
            set expanded_directory (string replace -r '\$HOME' "$HOME" "$directory")
            if string match -q -- "$expanded_directory*" "$PWD"
                echo $badge
                break
            end
        end <~/.badges
    end

    # cd to "git root"
    function grt
        set root (git rev-parse --show-toplevel 2>/dev/null)
        if test -n "$root"
            cd $root
        end
    end
end
