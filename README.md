# nvim-config

## Requirement

- Ruby
    - neovim
    - solargraph
    - rubocop
- Python
    - neovim
    - pylint
    - flake8
- node.js
    - neovim
    - standard
    - jsonlint
    - dockerfile-language-server-nodejs
    - bash-language-server
- yarn

## Usage

deploy

```sh
echo 'export XDG_CONFIG_HOME=~/.config' >> ~/.bashrc
source ~/.bashrc
mkdir ~/.config
git clone https://github.com/hotaru51/nvim-config.git ~/.config/nvim
./package_setup.sh ruby python node
```

nvim

```sh
:UpdateRemotePlugins
:CocCommand python.setInterpreter
```
