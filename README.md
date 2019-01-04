# My dotfiles

My dotfiles for neo vim

## Install necessary programs (Mac OS X only)

    # Remove old fzf search if available
    ~/.fzf/uninstall
    rm -rf ~/.fzf

    brew install tmux reattach-to-user-namespace the_silver_searcher git tig urlview htop-osx

    # Optional
    sudo -i
    gem install tmuxinator rubocop --no-rdoc --no-ri

    # install neovim
    brew tap neovim/neovim
    brew install neovim --HEAD
    sudo -H pip install --upgrade pip setuptools
    pip install --user --upgrade neovim

## Setup nvim folder

    mkdir -p ~/.vim/{plugged,snippets,cache,colors}
    mkdir -p ~/.cache/{swap,backup,undo}
    touch ~/.cache/NERDTreeBookmarks

    # nvim
    mkdir -p ~/.config
    ln -sf ~/.vim ~/.config/nvim

    # Install vim-plug
    curl --silent -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Setup tmux folder

    mkdir -p ~/.tmux/logs

## Clone and link configs

    git clone https://github.com/dangnm/wdotfiles.git ~/wdotfiles

    # For neovim
    ln -sf ~/wdotfiles/init.vim ~/.config/nvim/init.vim

    # For vim
    ln -sf ~/wdotfiles/init.vim ~/.vim/.vimrc
    ln -sf ~/wdotfiles/init.vim ~/.vimrc

    # tmux
    ln -sf ~/wdotfiles/tmux.conf ~/.tmux.conf

## Install monokai theme
    mkdir -p ~/.vim/{colors}

    # For neovim
    ln -sf ~/wdotfiles/colors/monokai.vim ~/.config/nvim/colors/monokai.vim
    ln -sf ~/wdotfiles/colors/gruvbox.vim ~/.config/nvim/colors/gruvbox.vim

## Start vim and install plugins

    nvim +PlugInstall +qall
    vim  +PlugInstall +qall

## Uninstall configs
    unlink ~/.vim/.vimrc
    unlink ~/.vimrc
    unlink ~/.config/nvim/init.vim
    unlink ~/.config/nvim/colors/monokai.vim
    unlink ~/.config/nvim/colors/gruvbox.vim
