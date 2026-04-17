# Garcon

A thin Servant-based HTTP wrapper around [Chompsky](https://github.com/real-limoges/chompsky). Garcon exposes Chompsky's parsing capabilities over HTTP without owning any domain logic.

```
Client ──HTTP──▶ Garcon (Servant/Warp) ──▶ Chompsky
```

## Prerequisites

- GHC 9.12.2
- Cabal 3.14+
- Sibling checkouts of [chompsky](https://github.com/real-limoges/chompsky) and [hazy](https://github.com/real-limoges/hazy):

```
parent/
├── garcon/
├── chompsky/
└── hazy/
```

## Build & Run

```bash
cabal build all
cabal run garcon        # serves on port 4040
```

## Test

```bash
cabal test --test-show-details=direct
```

## Docker

The Docker build clones chompsky and hazy from GitHub, so no sibling checkouts are needed.

```bash
docker build -t garcon .
docker run -p 4040:4040 garcon
```

## Project Structure

| Module | Role |
|---|---|
| `Garcon.API` | Servant type-level API definitions |
| `Garcon.Server` | Handler implementations (delegates to Chompsky) |
| `Garcon.App` | WAI Application wiring |
| `app/Main.hs` | Warp entry point |

## License

MIT
