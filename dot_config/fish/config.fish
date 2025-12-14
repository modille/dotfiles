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
    abbr --add gds "git diff --staged"
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

    abbr --add lzd lazydocker

    abbr --add wip "git commit --no-verify -m 'WIP [skip ci]'"
    # abbr --add handoff "git add --all && git commit --amend --no-edit && git push --force-with-lease"

    if test -e $HOME/.iterm2_shell_integration.fish
        source $HOME/.iterm2_shell_integration.fish
    end
    function iterm2_print_user_vars
        iterm2_set_user_var badge (dir_badges)
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

    starship init fish | source
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
if test -d /opt/homebrew/opt/mysql@8.4
    # If you need to have mysql@8.4 first in your PATH, run:
    fish_add_path /opt/homebrew/opt/mysql@8.4/bin

    # For compilers to find mysql@8.4 you may need to set:
    set -gx LDFLAGS "-L/opt/homebrew/opt/mysql@8.4/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/opt/mysql@8.4/include"

    # For pkgconf to find mysql@8.4 you may need to set:
    set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/mysql@8.4/lib/pkgconfig"
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
if test -d /opt/homebrew/opt/libpq
    # If you need to have libpq first in your PATH, run:
    fish_add_path /opt/homebrew/opt/libpq/bin

    # For compilers to find libpq you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/libpq/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/libpq/include

    # For pkg-config to find libpq you may need to set:
    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/libpq/lib/pkgconfig
end
if test -d /opt/homebrew/opt/curl
    # If you need to have curl first in your PATH, run:
    fish_add_path /opt/homebrew/opt/curl/bin

    # For compilers to find curl you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/curl/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/curl/include

    # For pkg-config to find curl you may need to set:
    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/curl/lib/pkgconfig
end
if test -d /opt/homebrew/opt/libffi
    # For compilers to find libffi you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/libffi/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/libffi/include

    # For pkg-config to find libffi you may need to set:
    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/libffi/lib/pkgconfig
end

if test -d /opt/homebrew/opt/libiconv
    # If you need to have libiconv first in your PATH, run:
    fish_add_path /opt/homebrew/opt/libiconv/bin

    # For compilers to find libiconv you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/libiconv/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/libiconv/include
end
# ASDF configuration code
if test -z "$ASDF_DATA_DIR"
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
