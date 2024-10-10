if status is-interactive
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore

    # https://github.com/wez/wezterm/issues/2781#issuecomment-1324143452
    set fish_vi_force_cursor 1

    abbr --add be "bundle exec"

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
    abbr --add gf "git fetch"
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

    alias lazyvim "NVIM_APPNAME=lazyyy /opt/homebrew/bin/nvim"
    alias nvim "NVIM_APPNAME=lazyyy /opt/homebrew/bin/nvim"

    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end

# From homebrew caveats
if test -d /opt/homebrew/opt/mysql@8.0
    # If you need to have mysql@8.0 first in your PATH, run:
    fish_add_path /opt/homebrew/opt/mysql@8.0/bin
    # For compilers to find mysql@8.0 you may need to set:
    set -gx LDFLAGS "-L/opt/homebrew/opt/mysql@8.0/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/opt/mysql@8.0/include"
    # For pkg-config to find mysql@8.0 you may need to set:
    set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/mysql@8.0/lib/pkgconfig"
end
if test -d /opt/homebrew/opt/sqlite
    # If you need to have sqlite first in your PATH, run:
    fish_add_path /opt/homebrew/opt/sqlite/bin

    # For compilers to find sqlite you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/sqlite/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/sqlite/include

    # For pkg-config to find sqlite you may need to set:
    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/sqlite/lib/pkgconfig
end
