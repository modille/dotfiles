# From homebrew caveats

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

if test -d /opt/homebrew/opt/libpq
    # If you need to have libpq first in your PATH, run:
    fish_add_path /opt/homebrew/opt/libpq/bin

    # For compilers to find libpq you may need to set:
    set -gx LDFLAGS -L/opt/homebrew/opt/libpq/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/libpq/include

    # For pkg-config to find libpq you may need to set:
    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/libpq/lib/pkgconfig
end

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
