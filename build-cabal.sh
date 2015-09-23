#!/bin/sh
ghc --make Setup.hs
./Setup configure --extra-prog-path=$HOME/.cabal/bin/$(ghc-version) --bindir=$HOME/.cabal/bin/$(ghc-version) --libexecdir=$HOME/.cabal/libexec/$(ghc-version) --sysconfdir=$HOME/.cabal/etc/$(ghc-version) --user
./Setup build
./Setup install --user
