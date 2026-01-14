# P6's POSIX.2: p61password

## Table of Contents

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

## Contributing

- [How to Contribute](<https://github.com//.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com//.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

### Functions

## p61password

### p61password/init.zsh

- p6_1password_account_add(address, email)
- p6_1password_account_signin([account=$OP_ACCOUNT])
- p6_1password_vault_select(vault_name)
- p6_1password_whoami()
- p6df::modules::p61password::deps()
- str email = p6_1password_whoami_email()

## p61password/lib

### p61password/lib/cli.sh

- p6_1password_cli_item_archive(item_id, [vault_name=$OP_VAULT_NAME])
- p6_1password_cli_item_delete(item_id, [vault_name=$OP_VAULT_NAME])
- str pw = p6_1password_cli_item_get_password(item_id, [vault_name=$OP_VAULT_NAME])
- str user = p6_1password_cli_item_get_username(item_id, [vault_name=$OP_VAULT_NAME])
- stream  = p6_1password_cli_item_create(title, username, password, url, [vault_name=$OP_VAULT_NAME])
- stream  = p6_1password_cli_item_get(item_id, [vault_name=$OP_VAULT_NAME])
- stream  = p6_1password_cli_item_update(item_id, username, password, url, [vault_name=$OP_VAULT_NAME])
- stream  = p6_1password_cli_vault_list([vault_name=$OP_VAULT_NAME])
- stream  = p6_1password_cli_vaults_list()

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── cli.sh
└── README.md

2 directories, 3 files
```

## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
