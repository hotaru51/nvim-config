#!/bin/bash

set -ue

if [ "$#" -le 0 ]; then
    echo "usage ./`basename $0` [ruby|python|node]..."
    exit 1
fi

# ruby
function ruby_setup() {
    echo '=== gem install'
    gem install \
        neovim \
        solargraph \
        rubocop
    echo '=== yard gems'
    yard gems
    echo '=== yard config'
    yard config --gem-install-yri
}

# python2
function python2_setup() {
    echo '=== pip2 install'
    pip2 install neovim
}

# python3
function python3_setup() {
    echo '=== pip3 install'
    pip3 install \
        neovim \
        pylint \
        flake8 \
        cfn-lint
}

# node
function node_setup() {
    echo '=== npm install'
    npm install -g \
        neovim \
        standard \
        jsonlint \
        dockerfile-language-server-nodejs \
        bash-language-server
}

# main
for lang in "$@"
do
    case "${lang}" in
        'ruby' )
            ruby_setup
            ;;
        'python2' )
            python2_setup
            ;;
        'python3' )
            python3_setup
            ;;
        'node' )
            node_setup
            ;;
        * )
            echo "invalid variable [${lang}]"
            ;;
    esac
done
