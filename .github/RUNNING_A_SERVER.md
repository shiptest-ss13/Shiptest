# INSTALLATION

First-time installation should be fairly straightforward. First, you'll need
BYOND installed. You can get it from https://www.byond.com/download. Once you've done
that, extract the game files to wherever you want to keep them. This is a
sourcecode-only release, so the next step is to compile the server files.

Double-click `BUILD.bat` in the root directory of the source code. This'll take
a little while, and if everything's done right you'll get a message like this:

```
saving shiptest.dmb (DEBUG mode)
shiptest.dmb - 0 errors, 0 warnings
```

If you see any errors or warnings, something has gone wrong - possibly a corrupt
download or the files extracted wrong. If problems persist, ask for assistance
in [the discord](https://shiptest.net/discord)

You'll also want to edit config/admins.txt to remove the default admins and add
your own. "Game Master" is the highest level of access, and probably the one
you'll want to use for now. You can set up your own ranks and find out more in
config/admin_ranks.txt

The format is

```
byondkey = Rank
```

where the admin rank must be properly capitalised.

This codebase also depends on a native library called rust-g. A precompiled
Windows DLL is included in this repository, but Linux users will need to build
and install it themselves. Directions can be found at the [rust-g
repo](https://github.com/tgstation/rust-g).

**Unlike other servers,** Shiptest also uses an external library called Auxmos, which
needs to be compiled on linux systems. Like with rust-g, Windows hosts should be fine, as the DLL
it needs is shipped with the repository. Please download and install [auxmos](https://github.com/Putnam3145/auxmos)
using the instructions provided if you're running a linux system.
`tools/ci/build_auxmos.sh` can also be used if you're in a rush.

Finally, to start the server, run Dream Daemon and enter the path to your
compiled shiptest.dmb file. Make sure to set the port to the one you
specified in the config.txt, and set the Security box to 'Trusted'. Then press GO
and the server should start up and be ready to join. It is also recommended that
you set up the SQL backend (see below).

## UPDATING

To update an existing installation, first back up your /config and /data folders
as these store your server configuration, player preferences and banlist.

Then, extract the new files (preferably into a clean directory, but updating in
place should work fine), copy your /config and /data folders back into the new
install, overwriting when prompted except if we've specified otherwise, and
recompile the game. Once you start the server up again, you should be running
the new version.

## HOSTING

If you'd like a more robust server hosting option for tgstation and its
derivatives. Check out our server tools suite at
https://github.com/tgstation/tgstation-server

## SQL SETUP

The SQL backend requires a Mariadb server running 10.2 or later. Mysql is not 
supported, but Mariadb is a drop in replacement for mysql. SQL is required for the 
library, stats tracking, admin notes, and job-only bans, among other features,
mostly related to server administration. Your server details go in /config/dbconfig.txt, 
and the SQL schema is in /SQL/tgstation_schema.sql and /SQL/tgstation_schema_prefix.sql 
depending on if you want table prefixes. 

More detailed setup instructions are located here: https://shiptest.net/wiki/Downloading_the_source_code#Setting_up_the_database

## WEB/CDN RESOURCE DELIVERY

Web delivery of game resources makes it quicker for players to join and reduces some of the stress on the game server.

1. Edit compile_options.dm to set the `PRELOAD_RSC` define to `0`
1. Add a url to config/external_rsc_urls pointing to a .zip file containing the .rsc.
    - If you keep up to date with Shiptest you could reuse our rsc cdn at https://cdn.shiptest.net/rsc/rsc.zip. Otherwise you can use cdn services like CDN77 or cloudflare (requires adding a page rule to enable caching of the zip), or roll your own cdn using route 53 and vps providers.
    - Regardless even offloading the rsc to a website without a CDN will be a massive improvement over the in game system for transferring files.

## IRC BOT SETUP

Included in the repository is a python3 compatible IRC bot capable of relaying adminhelps to a specified
IRC channel/server, see the /tools/minibot folder for more
