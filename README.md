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
    For each version of GHC you want to use, follow the following steps:

    1. Set VERSION to the desired version

        `export VERSION=7.6.3`

    2. Download and unpack the tarball.

        `wget "http://www.haskell.org/ghc/dist/$VERSION/ghc-$VERSION-x86_64-unknown-linux.tar.bz2"`

        `tar jxf "ghc-$VERSON-x86_64-unknown-linux.tar.bz2"`

        `cd "ghc-$VERSION"`

    3. Configure and install GHC

        `./configure --prefix="/opt/ghc/$VERSION"`

        `sudo make install`

    4. Setup cabal

        `cd ..`

        `wget -c http://hackage.haskell.org/packages/archive/cabal-install/cabal-install-1.18.0.2.tar.gz`

        `tar zxf cabal-install-1.18.0.2.tar.gz`

        `cd cabal-install-1.18.0.2`

        `PATH="/opt/ghc/$VERSION:$PATH" "PREFIX=$HOME/.cabal/$VERSION" sh bootstrap.sh`

        `mkdir -p "$HOME/.cabal/.packages"`

        `ln -s "$HOME/.cabal/.packages" "$HOME/.cabal/$VERSION/packages"`

        `PATH="/opt/ghc/$VERSION:$HOME/.cabal/VERSION:$PATH" cabal update --config-file="$HOME/.cabal/$VERSION/config"`

        `sed -i "s|$HOME/.cabal|$HOME/.cabal/$VERSION|g;s|-- prefix|   prefix|g" "$HOME/.cabal/$VERSION/config"`

        `cd ..`

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

    ghc-version auto

then the most recent version of GHC installed on your system will be
automatically selected by default.
