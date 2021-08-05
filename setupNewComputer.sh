#!/bin/sh

### change apt mirror ###
sudo sed -i 's/us/tw/g' /etc/apt/sources.list

### git config ###
echo -n "Enter the global user for Git: "
read GITUSER
git config --global user.name "${GITUSER}"

echo -n "Enter the global user emacs for Git: "
read GITEMAIL
git config --global user.email "${GITEMAIL}"
git config --global alias.b status
git config --global alias.co checkout
git config --global alias.st status

### update all the software ###
sudo apt update
sudo apt upgrade -y

### emacs ###
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt update
sudo apt install emacs27 -y
## dependencies for emacs packages ##
sudo apt install fonts-hack -y
sudo apt install sqlite -y
## install my config ##
git clone git@github.com:sunzhe96/.emacs.d.git "$HOME/.emacs.d"

### vs code ###
sudo apt install code -y

### golang ###
sudo apt install golang -y

### sunpinyi ###
sudo apt install fcitx-sunpinyin -y

###  racket ###
sudo apt install racket -y

### r ###
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
sudo apt update
sudo apt install r-base r-base-dev -y

### oh-my-zsh ###
sudo apt install zsh -y
chsh --shell $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

