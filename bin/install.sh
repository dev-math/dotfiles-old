#!/bin/env bash
set -e

HELPER="yay"

echo "Welcome!"

read -p "Backup your files? (y/n) (default \"Yes\"): " yn
case $yn in
	n*|N*)
	echo "Backup disabled. Continuing..."
	BACKUP="no"
	;;
	y*|Y*|*)
	echo "Backup enabled. Continuing..."
	BACKUP="yes"
	;;
esac

echo "Checking some things, updating others..."
sudo pacman -Syu --noconfirm --needed base-devel git wget 

# install AUR helper (yay)
if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
    git clone https://aur.archlinux.org/$HELPER.git
    (cd $HELPER && makepkg -si && rm -Rf $(pwd))
fi

# Install fonts
mkdir -p ~/.local/share/fonts
cp -r ./misc/fonts/* ~/.local/share/fonts/
fc-cache

# choose video card driver
echo "1) xf86-video-intel"
echo "2) xf86-video-amdgpu" 
echo "3) nvidia"
echo "4) Skip"
read -p "Choose your video card driver (default 4): " vid

case $vid in 
1)
	DRI='xf86-video-intel'
	;;
2)
	DRI='xf86-video-amdgpu'
	;;

3)
	DRI='nvidia nvidia-settings nvidia-utils'
	;;

4|*)
	DRI=""
	;;
esac

# install dependencies
yay -S --noconfirm --needed brave-bin \
	code \
	discord \
	feh \
	i3lock-color-git \
	kdeconnect \
	kitty \
	maim \
	man-db \
	man-pages \
	neofetch \
	networkmanager \
	papirus-icon-theme-git \
	pavucontrol \
	picom \
	playerctl \
	pulseaudio \
	pulseaudio-alsa \
	python-pip \
	python-pywal \
	python-gobject \
	qt5-tools \
	rofi \
	spotify \
	spicetify-cli \
	sshfs \
	sudo \
	texinfo \
	thunar-extended \
	unzip \
	vi \
	vim \
	xdg-user-dirs \
	xorg-server \
	xorg-xprop \
	xorg-xrdb \
	zathura \
	zathura-djvu \
	zathura-pdf-mupdf \
	zathura-ps \
	zathura-cb \
	zip \
	zsh \
	zsh-completions \
	$DRI

# choose display manager
echo "1) SDDM"
echo "2) LightDM"
echo "3) Slim"
echo "4) Skip (you will need a .xinitrc)"
read -p "Choose your display manager(default 4): " dis

case $dis in 
1)
	sudo pacman -S --noconfirm --needed sddm
	sudo systemctl enable sddm.service

	# SDDM  config file
	# se existe arquivos na pasta apagar tudo 
	[ $BACKUP = yes ] && [ -e /etc/sddm.conf.d/custom ] && sudo mv /etc/sddm.conf.d/custom /etc/sddm.conf.d/custom-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	! [ -e /etc/sddm.conf.d ] && sudo mkdir -p /etc/sddm.conf.d
	sudo cp -r config/sddm_user_settings.conf /etc/sddm.conf.d/custom
	;;

2)
	yay -S --noconfirm --needed lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-glorious
	# Set default lightdm greeter to lightdm-webkit2-greeter
	sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
	# Set default lightdm-webkit2-greeter theme to Glorious
	sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
	sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf

	sudo systemctl enable lightdm
	;;

3)
	sudo pacman -S --noconfirm --needed slim
	sudo systemctl enable slim.service
	;;

4|*)
	;;
esac

# config files

install_i3() {
	[ $BACKUP = yes ] && [ -e ~/.config/i3 ] && mv ~/.config/i3 ~/.config/i3-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/i3 ~/.config/
}

install_awesome() {
	[ $BACKUP = yes ] && [ -e ~/.config/awesome ] && mv ~/.config/awesome ~/.config/awesome-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/awesome ~/.config/
}

install_polybar() {
	[ $BACKUP = yes ] && [ -e ~/.config/polybar ] && mv ~/.config/polybar ~/.config/polybar-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/polybar ~/.config/
}

# Kitty
[ $BACKUP = yes ] && [ -e ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/kitty ~/.config/kitty

# Picom
[ $BACKUP = yes ] && [ -e ~/.config/picom.conf ] && mv ~/.config/picom.conf ~/.config/picom-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/picom.conf ~/.config/picom.conf

# Scripts
cp -r bin/* ~/.local/bin/

# Pywal
mkdir -p ~/.config/wal/templates
cp -r config/wal/templates/* ~/.config/wal/templates/
# Symlink pywal files
ln -sf ~/.cache/wal/.Xresources ~/
mkdir -p ~/.config/zathura
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/
chmod +x ~/.cache/wal/lock*
ln -sf ~/.cache/wal/lock-alpha.sh ~/.local/bin/lockscreen

# Wallpapers
ln -sf misc/wallpapers ~/Pictures/

# Services
sudo systemctl enable NetworkManager.service

# ZSH
# backup file
[ $BACKUP = yes ] && [ -e ~/.zshrc ] && mv ~/.zshrc ~/.zshrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
# install oh-my-zsh
! [ -e ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install spaceship theme
! [ -e $ZSH_CUSTOM/themes/spaceship-prompt ] && sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo rm "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# install zinit
sh -c "$(curl -fsSL https://git.io/zinit-install)"
# zsh cfg file
cp -r ./.zshrc ~/
# change default shell to zsh
chsh -s $(which zsh)

# choose config

echo "1) i3-gaps + "
echo "2) i3-gaps"
echo "3) AwesomeWM [unsupported]"
read -p "Choose your system(default 1): " systemopt

case $systemopt in
2)
	install_i3
	install_polybar
	yay -S --noconfirm --needed i3-gaps polybar dunst

	# Install dunst cfg
	[ $BACKUP = yes ] && [ -e ~/.config/dunst/dunstrc ] && mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	mkdir -p ~/.config/dunst
	ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
	;;
3)
	yay -S --noconfirm --needed awesome-git jq fortune-mod redshift xdotool network-manager-applet
	install_awesome
	# in notebook isntall acpid
	# sudo systemctl enable acpid.service
	;;
4)
	;;
1|*)
	install_i3
	;;
esac

echo "Done."
