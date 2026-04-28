function tab_color --description "Set iTerm2 tab color using RGB values"
    set -l red $argv[1]
    set -l green $argv[2]
    set -l blue $argv[3]

    printf "\033]6;1;bg;red;brightness;$red\a"
    printf "\033]6;1;bg;green;brightness;$green\a"
    printf "\033]6;1;bg;blue;brightness;$blue\a"
end

function tab_nvim
    tab_color 136 198 73
end

function tab_claude
    tab_color 222 115 86
end

function tab_reset
    printf "\033]6;1;bg;*;default\a"
end

function iterm2_tab_preexec --on-event fish_preexec
    set -l cmd (string split -m 1 ' ' -- $argv)[1]

    switch $cmd
        case nvim
            tab_nvim
        case claude
            tab_claude
        case '*'
            tab_reset
    end
end

function iterm2_tab_postexec --on-event fish_postexec
    tab_reset
end
