# BullsAndCows

## to initialize
```
stack --resolver lts-12.26 new BullsAndCows
```

## to compile / run
```
stack build
stack exec BullsAndCows-exe
```

## to run as a script

Include `src` directory

Include `random` package

```
stack --resolver lts-12.21 script --ghc-options -isrc --package random -- app/Main.hs
```

or altenatively:

```
./app/Main.hs
```

## to update .cabal
```
stack setup
```

## alternatives:
```
stack ghci
```
