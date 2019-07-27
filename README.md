# nvim-config

## Requirement

- Ruby
  - neovim
  - solargraph
  - rubocop
- Python
  - neovim
  - python-language-server
  - flake8
- node.js
  - neovim
  - standard
  - jsonlint
- yarn

## Usage

deploy

```sh
echo 'export XDG_CONFIG_HOME=~/.config' >> ~/.bashrc
source ~/.bashrc
mkdir ~/.config
git clone https://github.com/hotaru51/nvim-config.git ~/.config/nvim
```

nvim

```
:UpdateRemotePlugins
:CocInstall coc-solargraph coc-pyls coc-tsserver coc-html coc-css coc-json coc-yaml
```
