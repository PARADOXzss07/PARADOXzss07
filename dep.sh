#!/bin/bash
set -e
t="$HOME/.cache/depends/"
sudo rm -rf $t
mkdir -p $t
cd $t
sudo xbps-install -S
sudo xbps-install -y gnome-bluetooth bluez-cups bluez
sudo xbps-install -y gtk4-devel libadwaita-devel python3-pip
sudo xbps-install -y coreutils wl-clipboard xdg-utils cmake curl fuzzel rsync wget ripgrep jq nodejs meson gjs axel
sudo npm install --location=global typescript

sudo xbps-install cliphist


# ? libdbusmenu-gtk4
sudo xbps-install -y tinyxml-devel tinyxml tinyxml2 tinyxml2-devel gtkmm-devel gtksourceviewmm-devel gtksourceview5 gtksourceview5-devel gtksourceviewmm-devel gtksourceviewmm cairomm-devel cairomm1.16-devel cairomm cairomm1.16
sudo xbps-install -y python3-build python3-Pillow pywal python3-setuptools_scm python3-wheel
sudo xbps-install -y xrandr xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
sudo xbps-install -y pavucontrol wireplumber libdbusmenu-gtk3-devel libdbusmenu-gtk3 playerctl swww yad

sudo xbps-install -y scdoc

cd $t
git clone  https://github.com/ReimuNotMoe/ydotool
cd ydotool
mkdir build && cd build
cmake -DSYSTEMD_USER_SERVICE=OFF -DSYSTEMD_SYSTEM_SERVICE=ON ..
make -j `nproc`
sudo cp ydotool /usr/local/bin
sudo cp ydotoold /usr/local/bin
sudo chmod +s $(which ydotool)
sudo mkdir -p /etc/sv/ydotoold
sudo cat << EOF | sudo tee /etc/sv/ydotoold/run
#!/bin/sh
/usr/local/bin/ydotoold
EOF
sudo chmod +x /etc/sv/ydotoold/run
sudo ln -sf /etc/sv/ydotoold /var/service/
sudo sv up ydotoold


sudo xbps-install -y webp-pixbuf-loader gtk-layer-shell-devel wxWidgets-gtk3 wxWidgets-gtk3-devel gtksourceview gtksourceview-devel gobject-introspection upower
sudo xbps-install -y polkit-gnome gnome-keyring gnome-control-center gnome-bluetooth NetworkManager gammastep gnome-bluetooth
sudo xbps-install -y brightnessctl ddcutil

#dart-sass
cd $t
wget https://github.com/sass/dart-sass/releases/download/1.77.0/dart-sass-1.77.0-linux-x64.tar.gz
tar -xzf dart-sass-1.77.0-linux-x64.tar.gz
cd dart-sass
sudo cp -rf * /usr/local/bin/

# ? Mesa-libGLESv2-devel
sudo xbps-install -y python3-pywayland python3-psutil wl-clipboard libwebp-devel file-devel libdrm-devel libgbm-devel pam-devel  libsass-devel libsass


sudo xbps-install -y wlogout


sudo xbps-install -y cargo
cd $t
git clone https://github.com/Kirottu/anyrun.git # Clone the repository
cd anyrun # Change the active directory to it
cargo build --release # Build all the packages
cargo install --path anyrun/ # Install the anyrun binary
sudo cp $HOME/.cargo/bin/anyrun /usr/local/bin/
mkdir -p ~/.config/anyrun/plugins # Create the config directory and the plugins subdirectory
cp target/release/*.so ~/.config/anyrun/plugins # Copy all of the built plugins to the correct directory
cp examples/config.ron ~/.config/anyrun/config.ron # Copy the default config file


# ttf-material-symbols-variable-git ttf-space-mono-nerd ttf-readex-pro jetbrains-mono-fonts gdouros-symbola-fonts lato-fonts
# I do not know how to fix fonts, so I copied them from Arch (all from /usr/share/fonts/ on Arch to /usr/local/share/fonts/ on Void)
sudo xbps-install -y adwaita-plus qt5ct qt6-wayland-devel qt6-wayland-tools qt6-wayland fontconfig fish-shell foot starship
sudo xbps-install -y swappy wf-recorder grim tesseract tesseract-ocr-all slurp
sudo xbps-install -y gobject-introspection gjs-devel pulseaudio pulseaudio-devel python3-devel gettext

# color-generation
# ? libxdp-devel typelib-1_0-Xdp-1_0 typelib-1_0-XdpGtk3-1_0 typelib-1_0-XdpGtk4-1_0
pip3 install materialyoucolor --upgrade --break-system-packages
pip3 install material-color-utilities-python base anyascii svglib libsass --upgrade --break-system-packages
sudo xbps-install -y python3-regex unzip
sudo xbps-install -y python3-gobject-devel libsoup-devel blueprint-compiler xz

sudo xbps-install -y python3-lxml libportal libportal-gtk4 libportal-gtk4-devel bc fcitx5
cd $t
git clone https://github.com/GradienceTeam/Gradience.git
cd Gradience
pip3 install -r requirements.txt --break-system-packages
git submodule init
git submodule update
meson setup builddir
meson configure builddir -Dprefix="$(pwd)/builddir" -Dbuildtype=debug
ninja -C builddir install

echo work!! && exit