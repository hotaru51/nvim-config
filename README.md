# nvim-config

## Requirement

* Ruby
* Python
* node.js
* Go
* Terraform
* yarn
    * `markdown-preview.nvim` のビルドに使用

## Usage

deploy

```sh
echo 'export XDG_CONFIG_HOME=~/.config' >> ~/.bashrc
source ~/.bashrc
mkdir ~/.config
git clone https://github.com/hotaru51/nvim-config.git ~/.config/nvim
```

## AI系プラグインの有効化

業務利用か個人利用かに応じて環境変数 `HTR_NVIM_AI` に下記の値を設定する

* `business` : 業務利用の場合(copilot)
* `personal` : 個人利用の場合(WindsurfとGemini)
    * こちらの場合は `GEMINI_API_KEY` も設定する
