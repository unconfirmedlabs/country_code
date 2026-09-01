# Country Code

A Sui Move package providing validated ISO 3166-1 alpha-2 country codes as on-chain types.

## Overview

`country_code` provides a `CountryCode` struct that wraps a validated two-letter
ISO 3166-1 alpha-2 country code string. All 249 officially assigned codes are
supported. Invalid codes are rejected at construction time, so every
`CountryCode` value in your program is valid.

## Published packages

Both deployments are immutable.

| Network | Package ID | Transaction digest |
| --- | --- | --- |
| Mainnet | `0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611` | `7VYWhpwy1XDpYdPAL7maBzn5NXSzQo28yjFvGpqStniF` |
| Testnet | `0x69fb214a74d5253971a45b2d07f83f13ae96992dd38198d7bacb21e1f5fb5f81` | `AiKePDfZ38a7dG774bnsd1VxW234M8NR6snAAiPn7Y2H` |

## Usage

### Add as a dependency

```toml
[dependencies]
country_code = { git = "https://github.com/unconfirmedlabs/country_code.git", rev = "main" }
```

### Import and use

```move
module example::my_module;

use country_code::country_code::{Self, CountryCode};

public struct Address has key, store {
    id: UID,
    country: CountryCode,
}

public fun create_address(country: String, ctx: &mut TxContext): Address {
    Address {
        id: object::new(ctx),
        country: country_code::new(country), // aborts if invalid
    }
}
```

## API

### `country_code::country_code`

| Function | Signature | Description |
| --- | --- | --- |
| `new` | `public fun new(code: String): CountryCode` | Creates a `CountryCode`. Aborts with `EInvalidCountryCode` unless the string is an assigned ISO 3166-1 alpha-2 code. |
| `code` | `public fun code(country_code: &CountryCode): String` | Returns the underlying two-letter code string. |

### Types

- **`CountryCode`** — A wrapper struct with `copy`, `drop`, and `store` abilities.

### Errors

| Code | Name | Description |
| --- | --- | --- |
| 0 | `EInvalidCountryCode` | The provided string is not an assigned ISO 3166-1 alpha-2 country code. |

## License

MIT
