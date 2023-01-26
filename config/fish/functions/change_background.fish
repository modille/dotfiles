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

  # Neovim
  # https://github.com/chmln/nvim-ctrl
  switch $mode
    case dark
      nvim-ctrl 'lua require\'modille/colorscheme_dark\'.load();require\'modille/status_line_dark\'.load()'
    case light
      nvim-ctrl 'lua require\'modille/colorscheme_light\'.load();require\'modille/status_line_light\'.load()'
  end

  # iTerm2
  # Supported in 3.5.0
  # https://gitlab.com/gnachman/iterm2/-/issues/7943

  # Wallpaper
  # https://apple.stackexchange.com/questions/40644/how-do-i-change-desktop-background-with-a-terminal-command
  switch $mode
    case dark
      osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Users/odillem2/Pictures/dark.png"'
    case light
      osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Users/odillem2/Pictures/light.png"'
  end

  # Brave
  # WIP: Requires manual intervention for now
  # TODO: Use native messaging https://developer.chrome.com/docs/apps/nativeMessaging/
  switch $mode
    case dark
      open -a 'Brave Browser' 'https://chrome.google.com/webstore/detail/solarized-dark-refresh-th/jinmjipikfdhmacpjdddmpffflhehcah'
    case light
      open -a 'Brave Browser' 'https://chrome.google.com/webstore/detail/solarized-light/kkaomacmcjmeajgdkgbemiigiphgcabj'
  end

  # Firefox
  # TODO: Use native messaging https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging

  # Slack
  # TODO: Built-in sidebar themes can do this, but custom ones can't yet

  # bat, delta
  switch $mode
    case dark
      set -Ux BAT_THEME 'Solarized (dark)'
    case light
      set -Ux BAT_THEME 'Solarized (light)'
  end
end
