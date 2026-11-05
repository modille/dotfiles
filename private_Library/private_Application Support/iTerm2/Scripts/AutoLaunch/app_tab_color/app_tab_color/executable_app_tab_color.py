#!/usr/bin/env python3

import datetime
import iterm2
import os
import traceback

LOG_PATH = os.path.expanduser("~/.cache/app_tab_color.log")

colors = { "vi": (255, 255, 255),
           "emacs": (255, 0, 0),
           "nvim": (188, 214, 96),
           "claude": (217, 119, 87) }

def log(message):
    """Print to the iTerm2 script console and append to LOG_PATH."""
    line = f"{datetime.datetime.now():%H:%M:%S.%f} {message}"
    print(line, flush=True)
    try:
        os.makedirs(os.path.dirname(LOG_PATH), exist_ok=True)
        with open(LOG_PATH, "a") as f:
            f.write(line + "\n")
    except OSError:
        pass

async def SetTabColor(connection, session, color):
    # Profiles with "Use Separate Colors for Light and Dark Mode" ignore the
    # plain keys and read the (Light)/(Dark) variants, so set all three.
    change = iterm2.LocalWriteOnlyProfile()
    if color:
        change.set_tab_color(color)
        change.set_tab_color_light(color)
        change.set_tab_color_dark(color)
    change.set_use_tab_color(bool(color))
    change.set_use_tab_color_light(bool(color))
    change.set_use_tab_color_dark(bool(color))
    # log(f"set_profile_properties {change.values}")
    await session.async_set_profile_properties(change)
    # log("set_profile_properties ok")

async def UpdateTabColor(connection, session, job):
    rgb = colors.get(job)
    # log(f"session={session.session_id} jobName={job!r} -> {rgb}")
    await SetTabColor(connection, session, iterm2.Color(*rgb) if rgb else None)

async def main(connection):
    # log(f"started pid={os.getpid()}")
    app = await iterm2.async_get_app(connection)

    async def monitor(session_id):
        """Run for each session, including existing sessions. Watches the
        foreground job name, which works without shell integration."""
        # log(f"monitor start session={session_id}")
        try:
            session = app.get_session_by_id(session_id)
            if not session:
                # log(f"monitor: no session for {session_id}")
                return
            async with iterm2.VariableMonitor(
                    connection, iterm2.VariableScopes.SESSION, "jobName",
                    session_id) as mon:
                job = await session.async_get_variable("jobName")
                while True:
                    await UpdateTabColor(connection, session, job)
                    job = await mon.async_get()
        except Exception:
            # log(f"monitor crashed session={session_id}\n{traceback.format_exc()}")
            raise

    await iterm2.EachSessionOnceMonitor.async_foreach_session_create_task(
            app, monitor)

iterm2.run_forever(main)
