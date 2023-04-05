# https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
# https://raw.githubusercontent.com/fatih/dotfiles/main/fish/functions/change_background.fish
function change_background --argument mode_setting
  set -l mode "light"
  if test -z $mode_setting
    set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
    # When Light, you get a non-0 exit code with output:
    #   2022-07-04 14:43:51.299 defaults[50713:32971078]
    #   The domain/default pair of (kCFPreferencesAnyApplication, AppleInterfaceStyle) does not exist
    # When Dark, you get exit code 0 with output:
    #   Dark
    if test $status -eq 0
      set mode "dark"
    end
  else
    switch $mode_setting
      case light
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        set mode "light"
      case dark
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
        set mode "dark"
    end
  end

  # Tracks the current mode in a file, and only proceed if the new mode is different than the current mode
  set -l previous_mode (cat /Users/modille/.local/state/modille/current_background_mode.txt) > /dev/null
  if test $mode = $previous_mode
    return
  end
  echo "$mode" > /Users/modille/.local/state/modille/current_background_mode.txt

  # Neovim
  # Use Signal SIGWINCH autocmd via https://github.com/will/bgwinch.nvim (seen at https://gitlab.com/gnachman/iterm2/-/issues/7943)
  # Includes debounce, which was recommended by justinmk https://github.com/neovim/neovim/pull/18029#issuecomment-1094643497
  # 2023-04-04: iTerm2 was sending SIGWINCH to all running processes, but it seemed to have broken, so send it manually to nvim for now:
  pkill -WINCH "nvim"

  # iTerm2
  # Supported in 3.5.0
  # https://gitlab.com/gnachman/iterm2/-/issues/7943

  # bat, delta
  switch $mode
    case dark
      set -Ux BAT_THEME 'Solarized (dark)'
    case light
      set -Ux BAT_THEME 'Solarized (light)'
  end

  # Firefox
  # The Zen Fox extension README mentioned a fork that used native messaging
  # I applied those changes on top of the latest Zen Fox and it worked
  # TODO: Right now it just toggles anytime it receives a message. Ideally it should be told "light" or "dark" and only toggle if needed.
  pkill -USR1 -f "python.+zen_fox_toggle_light_dark.py"

  # Google Chrome
  # TODO: Use native messaging https://developer.chrome.com/docs/apps/nativeMessaging/
  switch $mode
    case dark
      open -a 'Google Chrome' 'https://chrome.google.com/webstore/detail/solarized-dark-refresh-th/jinmjipikfdhmacpjdddmpffflhehcah'
    case light
      open -a 'Google Chrome' 'https://chrome.google.com/webstore/detail/solarized-light/kkaomacmcjmeajgdkgbemiigiphgcabj'
  end

  # Wallpaper
  # TODO: This doesn't work for desktops that have a full-screened app in-focus
  switch $mode
    case dark
      osascript -e 'delay 0.5' -e 'tell application "System Events" to tell every desktop to set picture to "/Users/modille/Pictures/dark.png"'
    case light
      osascript -e 'delay 0.5' -e 'tell application "System Events" to tell every desktop to set picture to "/Users/modille/Pictures/light.png"'
  end

  # Slack
  # TODO: Built-in sidebar themes can do this, but custom ones can't yet
end
