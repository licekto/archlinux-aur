# docker build . -t archlinux-aur
# yay -S your-package --noconfirm

FROM archlinux

RUN pacman -Syyu --noconfirm --noprogressbar && pacman --noconfirm -S git base-devel go sudo vim

RUN useradd -m installer
RUN echo 'installer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir yay-git && chown -R installer yay-git

USER installer

RUN git clone https://aur.archlinux.org/yay-git.git && cd yay-git && makepkg -si --noconfirm

USER root
