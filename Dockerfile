# docker build . -t archlinux-aur
# yay -S your-package --noconfirm

FROM archlinux/archlinux:base-devel

RUN pacman -Syy --noconfirm
RUN pacman-key --init
RUN pacman-key --populate
RUN pacman -S --noconfirm archlinux-keyring
RUN pacman -Syyu --noconfirm --noprogressbar && pacman --noconfirm -S git base-devel go sudo vim

RUN useradd --system -m installer
RUN echo 'installer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir yay && chown -R installer yay

USER installer

RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -sri --needed --noconfirm

USER root
