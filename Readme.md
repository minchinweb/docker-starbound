# Starbound Server

Starbound is not a new game, having reached version 1.0 in 2016, and the latest
release (currently version 1.4.4) dating to August 2019. However, it is
expansive and quieting in a way few games have proved to be. And so, I still
play it.

To get this up and running,

## The Server Itself

You need to provide the Starbound server executable, and mount it to the
directory `/app`. If you own the game on Steam, you can download it with
`steamcmd` with something like this:

    steamcmd +login <steam_username> +@sSteamCmdForcePlatformType linux +force_install_dir ./starbound_linux +app_update 211820 +quit

Note that this will also download all your subscribed mods. The above command
can be run on Windows and will download the linux version of the game. It may
ask you for your password, and a one-time code (if you have SteamGuard/2FA
active).

Now copy over the server executable and the game assets over. In the end, you'll have something like this:

    app
      +- assets
      |    +- user
      |    |    +- songs
      |    |    |    +- 12 Days of Christmas.abc
      |    |    |    +- [a bunch of .abc files]
      |    |    `- _metadata
      |    `- packed.pak
      `- linux
          `- starbound_server

You may need to mark the `starbound_server` file as executable (`chmod +x starbound_server`).

## (Existing) Universe

If you want to move over your existing Universe, you can copy it to folder
mounted as the `config` directory. Something like this:

    config
      `- universe
           +- <hexi-decimal number>.clientcontext
           +- <numbers>_<numbers>_<numbers>.system
           +- <numbers>_<numbers>_<numbers>_<digit>.world
           +- [etc]
           +- universe.chunks
           `- universe.dat

(The actual files you have will depend on what parts of the universe you've
explored.) Locally, you may also have a `players` directory, but the server
doesn't need that.

## Mods

You can also add mods. One "trick" is that the directories specified in
`sbinit.config` are not searched recursively, so if you copy over the mods
directly as Steam downloads them, you'll have to list each folder individually.
Personally, I'll rename Steam's `contents.pak` to the `<steam Id>.pak` and drop
them into the root mods folder. (The root mods folder is set up to be picked up
by the included default configuration.)

The `mods` folder is a subfolder of the mounted `config` folder. Something like this:

    config
      `- mods
           +- 729480149.pak

## Ports

The server runs on port 21025 (which Docker exposes).

## Default Starbound Config

The included default starbound config (at `/config/sbinit.config`):

    {
        "assetDirectories" : [
            "/app/assets/",
            "/config/mods/"
        ],

        "storageDirectory" : "/config/storage/",

        "defaultConfiguration" : {
            "gameServerBind" : "*",
            "queryServerBind" : "*",
            "rconServerBind" : "127.0.0.1"
        }
    }

## Running Notes

If you change the mods, you'll have to restart the server for the changes to be
loaded.
