#!/usr/bin/env python3.10

import asyncio
import iterm2

# Any time the macOS system theme changes between Dark and Light, then the
# iTerm2 theme changes. And any time the iTerm2 theme changes, this script will
# invoke a fish script to change the macOS wallpaper, Neovim colorscheme, and
# various TUI themes.
#
# An alternative I used in the past was to compile my own Swift app
# (https://github.com/bouk/dark-mode-notify) and use a macOS daemon to keep it
# running.

# Mostly taken from this example
# https://iterm2.com/python-api/examples/theme.html#theme-example
#
# Then moved into AutoLaunch
# https://iterm2.com/python-api/tutorial/running.html?highlight=run#auto-run-scripts

async def update(connection, theme):
    process = await asyncio.create_subprocess_exec(
        "/opt/homebrew/bin/fish", "-c", "change_background"
    )
    await process.wait()

async def main(connection):
    app = await iterm2.async_get_app(connection)
    await update(connection, await app.async_get_variable("effectiveTheme"))
    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()
            await update(connection, theme)


iterm2.run_forever(main)
