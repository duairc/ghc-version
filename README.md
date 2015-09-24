# Quickly switch between different versions of GHC

**`ghc-version`** is a script written in pure, portable shell that allows you
to quickly and easily switch between different versions of GHC. This is
important if you're developing Haskell code that you want to be portable.

## Setup

1. First of all, check out this repository.

    `git clone https://github.com/duairc/ghc-version`

    `cd ghc-version`

2. Copy `ghc-version` to somewhere in your `PATH`.

    `sudo cp ghc-version /usr/local/bin/ghc-version`

    `sudo chmod +x /usr/local/bin/ghc-version`

3. Install the different versions of GHC that you want to use. By default,
    `ghc-version` looks in `/opt/ghc/V$ERSION` for installed versions of GHC.
    If you are using a Debian-based distribution, you can use the hvr's ghc
    PPA, whose GHC's packages install to this location.

    1. Add the PPA to your system's repositories.

        `sudo add-apt-repository ppa:hvr/ghc`

    2. Install the versions of GHC you want, e.g.:

        `sudo apt-get install ghc-7.6.3 ghc-7.8.4 ghc-7.10.3 ghc-head`

    3. Install cabal.

        `sudo apt-get install cabal-install-head`

4. Setup cabal

        mkdir -p "$HOME/.ghc-version/bin"
        cp cabal "$HOME/.ghc-version/bin/"
        chmod +x "$HOME/.ghc-version/bin/cabal"
        [ -d "$HOME/.cabal" ] && mv "$HOME/.cabal" "$HOME/.cabal.bak.$(date +%s)"
        mkdir -p "$HOME/.cabal/world"
        cp config "$HOME/.cabal/config"
        . ghc-version auto
        cabal update

## Usage

`ghc-version` relies entirely on environment variables and aliases to switch
between the different versions of GHC installed on your system. This means
that you can be using one version of GHC in one terminal and another version
in another terminal on the same system, and switching between versions is
entirely local.

    ghc-version 7.6 cabal install layers

This will compile and install the `layers` package and its dependencies using
GHC 7.6. When used in this way, `ghc-version` changes the version of GHC just
for the duration of the given command. If you want to change the version of
GHC for the whole session, you have to use `source`:

    source ghc-version 7.6

This can be abbreviated to:

    . ghc-version 7.6

When run with no arguments, `ghc-version` prints the current version of GHC.

## Auto-configuration

If you add the following line to your `.bashrc` file:

    . ghc-version auto

then the most recent version of GHC installed on your system will be
automatically selected by default.
