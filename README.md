# nvim-config

## Requirement

* Ruby
    * neovim
    * solargraph
    * rubocop
* Python
    * neovim
    * pylint
    * flake8
* node.js
    * neovim
    * standard
    * jsonlint
    * dockerfile-language-server-nodejs
    * bash-language-server
* yarn
* [terraform-ls](https://github.com/hashicorp/terraform-ls)

## Usage

deploy

```sh
echo 'export XDG_CONFIG_HOME=~/.config' >> ~/.bashrc
source ~/.bashrc
mkdir ~/.config
git clone https://github.com/hotaru51/nvim-config.git ~/.config/nvim
./package_setup.sh ruby python2 python3 node
```

nvim

```sh
:UpdateRemotePlugins
:CocCommand python.setInterpreter
:CocCommand go.install.gopls
```

## AI系プラグインの有効化

業務利用か個人利用かに応じて環境変数 `HTR_NVIM_AI` に下記の値を設定する

* `business` : 業務利用の場合(copilot)
* `personal` : 個人利用の場合(WindsurfとGemini)
    * こちらの場合は `GEMINI_API_KEY` も設定する
