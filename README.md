# Initial setup

### Packages
```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh fzf autojump libevent-dev ncurses-dev build-essential bison pkg-config ninja-build gettext cmake unzip curl
```

### oh-my-zsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### setup dotfiles
```sh
cd ~
mv .config{,-bkp}
mv .zshrc{,-bkp}
git clone --recurse-submodules https://github.com/mrjesma/dotfiles.git .config
ln -s ~/.config/zsh/zshrc .zshrc
ln -s ~/.config/git/gitconfig .gitconfig
omz reload
```

### build neovim and tmux
```sh
mkcd /tmp/build
take https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz
make CMAKE_BUILD_TYPE=Release
sudo make install
cd /tmp/build
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
cd tmux-*/
./configure
make && sudo make install
cd ~ && sudo rm -rf /tmp/build
```
