# pass-yaml

A [pass] extension for interacting with YAML stored in pass files.

## Description

**pass-yaml** is an extension for the [password-store] that allows users to read and manipulate password metadata stored as YAML in pass files. It leverages the [yq] command-line YAML processor to provide powerful querying capabilities for structured data within your password store.

The extension follows the pass convention where the first line contains the password, and subsequent lines contain metadata. pass-yaml processes these metadata lines as YAML, allowing you to store and query structured information like URLs, usernames, API keys, and other related data.

## Features

- Read YAML data from pass files using yq expressions
- Extract specific keys or values from YAML metadata
- Validate YAML format in pass files
- Bash completion support
- Integrates seamlessly with existing pass workflow

## Requirements

- [pass] (password-store) - The standard unix password manager
- [yq] >= 3.3 - Command-line YAML processor

## Installation

### From Source

```bash
git clone https://github.com/ecoutu/pass-yaml.git
cd pass-yaml
sudo make install
```

### Manual Installation

```bash
curl -LO https://github.com/ecoutu/pass-yaml/archive/v1.1.tar.gz
tar xzvf v1.1.tar.gz
cd pass-yaml-1.1
sudo make install
```

### Installation Paths

The installation will place files in the following locations:
- Extension script: `/usr/lib/password-store/extensions/yaml.bash`
- Man page: `/usr/share/man/man1/pass-yaml.1`
- Bash completion: `/etc/bash_completion.d/pass-yaml`

## Usage

### Basic Syntax

```bash
pass yaml <pass-name> [yq-expression]
pass yaml keys <pass-name> [yq-expression]
pass yaml values <pass-name> [yq-expression]
```

### Commands

#### `pass yaml <pass-name> [yq-expression]`
Display YAML data from the specified pass file. If no yq-expression is provided, shows all metadata.

#### `pass yaml keys <pass-name> [yq-expression]`
Show only the keys from the YAML data matching the expression.

#### `pass yaml values <pass-name> [yq-expression]`
Show only the values from the YAML data matching the expression.

### Examples

Assuming you have a pass file with the following structure:
```
mypassword123
url: https://example.com
username: john.doe
email: john@example.com
notes:
  created: 2023-01-15
  category: work
```

#### View all metadata
```bash
pass yaml mysite
```

#### Get specific field
```bash
pass yaml mysite .url
# Output: https://example.com
```

#### Get nested data
```bash
pass yaml mysite .notes.category
# Output: work
```

#### List all keys
```bash
pass yaml keys mysite
# Output: url, username, email, notes
```

#### Get all values
```bash
pass yaml values mysite
```

## File Format

pass-yaml expects pass files to follow this format:
1. First line: the password
2. Subsequent lines: YAML metadata (key-value pairs)

Example:
```
supersecretpassword
url: https://mywebsite.com
username: myuser
email: user@example.com
api_key: abc123xyz
notes:
  created: 2023-01-15
  expires: 2024-01-15
```

## Development

### Linting

Run shellcheck on the main script:
```bash
make lint
```

### Uninstall

To remove pass-yaml from your system:
```bash
sudo make uninstall
```

## Contributing

Contributions are welcome! Please feel free to submit issues and enhancement requests.

## License

Copyright © 2020 Emma Coutu

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See the [LICENSE](LICENSE) file for details.

## Links

- [Homepage](https://github.com/ecoutu/pass-yaml)
- [Bug Reports](https://github.com/ecoutu/pass-yaml/issues)
- [pass (password-store)](https://www.passwordstore.org/)
- [yq YAML processor](https://github.com/mikefarah/yq)

[pass]: https://www.passwordstore.org/
[password-store]: https://www.passwordstore.org/
[yq]: https://github.com/mikefarah/yq
