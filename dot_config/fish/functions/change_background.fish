# https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
# https://raw.githubusercontent.com/fatih/dotfiles/main/fish/functions/change_background.fish
function change_background --argument mode_setting
    set -l mode light
    if test -z $mode_setting
        set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
        # When Light, you get a non-0 exit code with output:
        #   2022-07-04 14:43:51.299 defaults[50713:32971078]
        #   The domain/default pair of (kCFPreferencesAnyApplication, AppleInterfaceStyle) does not exist
        # When Dark, you get exit code 0 with output:
        #   Dark
        if test $status -eq 0
            set mode dark
        end
    else
        switch $mode_setting
            case light
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
                set mode light
            case dark
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
                set mode dark
        end
    end

    # Wallpaper
    # Using macOS dynamic wallpapers instead
    # switch $mode
    #     case dark
    #         osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/dark.png\""
    #     case light
    #         osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/light.png\""
    # end

    # Tracks the current mode in a file, and only proceed if the new mode is different than the current mode
    mkdir -p "$HOME/.local/state/modille"
    set state_file "$HOME/.local/state/modille/current_background_mode.txt"
    if not test -e "$state_file"
        echo "$mode" >"$state_file"
    end
    set -l previous_mode (cat "$state_file") >/dev/null
    if test $mode = $previous_mode
        return
    end
    echo "$mode" >"$state_file"

    # Neovim
    # Use Signal SIGWINCH autocmd via https://github.com/will/bgwinch.nvim (seen at https://gitlab.com/gnachman/iterm2/-/issues/7943)
    # Includes debounce, which was recommended by justinmk https://github.com/neovim/neovim/pull/18029#issuecomment-1094643497
    # 2023-04-04: iTerm2 was sending SIGWINCH to all running processes, but it seemed to have broken, so send it manually to nvim for now:
    pkill -WINCH nvim

    # Kitty
    switch $mode
        case dark
            rm -f ~/.config/kitty/theme.conf
            ln -s ~/.config/kitty/dark-theme.conf ~/.config/kitty/theme.conf
        case light
            rm -f ~/.config/kitty/theme.conf
            ln -s ~/.config/kitty/light-theme.conf ~/.config/kitty/theme.conf
    end
    for pid in "$(ps -x | grep '/Applications/kitty.app/Contents/MacOS/kitty' | grep -v grep | awk '{ print $1 }')"
        # reload via SIGUSR1
        kill -SIGUSR1 $pid
    end

    # iTerm2
    # Supported in 3.5.0
    # https://gitlab.com/gnachman/iterm2/-/issues/7943

    # bat, delta, lazygit
    switch $mode
        case dark
            # set -Ux BAT_THEME 'Solarized (dark)'
            set -Ux BAT_THEME tokyonight_moon
            set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/dark_config.yml,$HOME/.config/lazygit/tokyonight_moon.yml"
        case light
            # set -Ux BAT_THEME 'Solarized (light)'
            set -Ux BAT_THEME tokyonight_day
            set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/light_config.yml,$HOME/.config/lazygit/tokyonight_day.yml"
    end

    # Firefox
    # The Zen Fox extension README mentioned a fork that used native messaging
    # I applied those changes on top of the latest Zen Fox and it worked
    # TODO: Right now it just toggles anytime it receives a message. Ideally it should be told "light" or "dark" and only toggle if needed.
    # pkill -USR1 -f "python.+zen_fox_toggle_light_dark.py"

    # Google Chrome
    # TODO: Use native messaging https://developer.chrome.com/docs/apps/nativeMessaging/
    # switch $mode
    #   case dark
    #     open -a 'Google Chrome' 'https://chrome.google.com/webstore/detail/solarized-dark-refresh-th/jinmjipikfdhmacpjdddmpffflhehcah'
    #   case light
    #     open -a 'Google Chrome' 'https://chrome.google.com/webstore/detail/solarized-light/kkaomacmcjmeajgdkgbemiigiphgcabj'
    # end

    # Slack
    # TODO: Built-in sidebar themes can do this, but custom ones can't yet
end
