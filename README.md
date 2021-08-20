# debian

DISCLAIMER: This githuvb repository was created with idea of quick copy of some of my settings. 
It is not optimalized in any case. Use at own liability!

All packages that needs to be installed:\
`apt install git doas vim zsh zsh-autosuggestions zsh-syntax-highlighting pulseaudio xorg x11-xserver-utils xinit i3blocks i3lock numlockx rofi feh scrot compton light xclip make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev rxvt-unicode-256color rxvt-unicode-256color vrms neofetch dnsutils htop nmap hping3`\

Set up dotfiles:\
`git clone https://github.com/AISK11/debian/ ~/debian && cd ~/debian/dotfiles`\
`cp -r .* ~ && cd ~`\
`chmod +x ~/.config/i3/scripts/*`\
`tar xvjf .icons.tar.bz2`\
`tar xvjf .themes.tar.bz2`\
`doas cp ~/debian/config_files/i3blocks.conf /etc/i3blocks.conf`\
`rm -rf ~/debian`

Set up vim and zsh as default:\
`update-alternatives --config editor`\
`chsh -s /bin/zsh`

Compile i3-gaps:\
`cd /etc/`\
`doas git clone https://www.github.com/Airblader/i3 i3-gaps && cd ./i3-gaps/`\
`doas mkdir -p build && cd build`\
`doas meson --prefix /usr/local`\
`doas ninja`\
`doas ninja install`

Reboot:\
`init 6`
