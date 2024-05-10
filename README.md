# My personal .config files repo
This is how my current work environment is configured - Windows machine + WSL2 + WezTerm 

## Setup WSL
In Windows command line run
```
wsl -l -o
wsl --install Ubuntu-22.04
```
Create the wsl.conf file with the following content: `sudo vi /etc/wsl.conf`
```
[network]
generateHosts = true
generateResolvConf = false

[boot]
systemd=true
```
Adjust resolv.conf according to your needs: `sudo vi /etc/resolv.conf`

Exit WSL and restart the distribution: `wsl --shutdown`

## Linux environment setup

### Packages
```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y autojump bison build-essential cmake curl fzf gcc gettext git jq libevent-dev make ncurses-dev neovim ninja-build pkg-config ripgrep unzip zsh
```

### Oh-my-zsh
Install [om-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Setup dotfiles
```sh
cd ~
mv .config{,-bkp}
mv .zshrc{,-bkp}
git clone --recurse-submodules https://github.com/mrjesma/dotfiles.git .config
ln -s ~/.config/zsh/zshrc .zshrc
ln -s ~/.config/git/gitconfig .gitconfig
omz reload
```

### Build neovim and tmux
Install [NeoVim](https://github.com/neovim/neovim) and [Tmux](https://github.com/tmux/tmux) from source
```sh
mkcd /tmp/build
take https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz
make CMAKE_BUILD_TYPE=Release && sudo make install

mkcd /tmp/build
take $(curl -s https://api.github.com/repos/tmux/tmux/releases/latest | jq -r '.assets[].browser_download_url')
cd tmux-*/
./configure
make && sudo make install

cd ~ && sudo rm -rf /tmp/build
```

### Reload tmux
Enter tmux and hit `PREFIX + I`

### Navi instalation
Install [Navi](https://github.com/denisidoro/navi)

`sudo BIN_DIR=/usr/local/bin bash -c "$(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"`

## Aditional Windows setup
### WezTerm
Download and install [WezTerm](https://wezfurlong.or) terminal emulator for windows
`https://wezfurlong.org/wezterm/install/windows.html#installing-on-windows`

Copy [wezterm.lua](wezterm/wezterm.lua) to `C:\Program Files\WezTerm` directory.

### win32yank.exe
Download win32yank and put it in your path (eg.: C:\Windows\System32) for a seamless clipboard between Windows and WSL. `https://github.com/equalsraf/win32yank`
