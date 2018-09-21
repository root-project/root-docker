# start with ArchLinux with base & base-devel
FROM base/devel

# set maintaner label
LABEL maintainer.name="Konstantin Gizdov"
LABEL maintainer.email="arch@kge.pw"

USER root

## Configure initial system
# set locale to United Kingdom UTF-8
RUN sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=en_GB.UTF-8' > /etc/locale.conf


# Make non-root user
RUN useradd -ms /bin/bash docker-user \
 && echo "docker-user ALL=NOPASSWD:/usr/bin/pacman" >> /etc/sudoers

# work in /tmp
WORKDIR /tmp

# enable gnupg for root user (for pacman)
RUN mkdir -p /root/.gnupg
RUN touch /root/.gnupg/dirmngr_ldapservers.conf
RUN dirmngr
# update keys for package signing
RUN pacman-key --init
RUN pacman-key --populate archlinux

# update core databases
RUN pacman -Sy

# Use all core in makepkg
RUN sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf

## Install requirements
# install Git
RUN pacman --noconfirm --needed -S git
# install freetype2 required by libAfterImage & ROOT
RUN pacman --noconfirm --needed -S freetype2

# change to non-root user for makepkg builds
USER docker-user

# build & install libAfterImage (libafterimage)
RUN git clone https://aur.archlinux.org/libafterimage.git /tmp/libafterimage
COPY fix_libafterimage_pkgbuild.patch /tmp/libafterimage
RUN cd /tmp/libafterimage && patch -p1 -i fix_libafterimage_pkgbuild.patch
RUN cd /tmp/libafterimage && makepkg -sri --asdeps --needed --noconfirm

# build & install UNU.RAN (unuran)
RUN git clone https://aur.archlinux.org/unuran.git /tmp/unuran
RUN cd /tmp/unuran && makepkg -sri --asdeps --needed --noconfirm

# build & install VDT (cern-vdt)
RUN git clone https://aur.archlinux.org/cern-vdt.git /tmp/cern-vdt
RUN cd /tmp/cern-vdt && makepkg -sri --asdeps --needed --noconfirm

# build & install XRootD (xrootd)
RUN git clone https://aur.archlinux.org/xrootd.git /tmp/xrootd
RUN cd /tmp/xrootd && makepkg -sri --asdeps --needed --noconfirm

# build & install Pythia (pythia)
RUN git clone https://aur.archlinux.org/pythia.git /tmp/pythia
RUN cd /tmp/pythia && makepkg -sri --asdeps --needed --noconfirm

# build & install OpenBLAS (openblas-lapack)
RUN git clone https://aur.archlinux.org/openblas-lapack.git /tmp/openblas-lapack
RUN cd /tmp/openblas-lapack && makepkg -sri --asdeps --needed --noconfirm

# install Python NumPy
User root
RUN pacman --noconfirm --needed -S python-numpy
User docker-user

# build & install ROOT (root-extra)
RUN git clone https://aur.archlinux.org/root-extra.git /tmp/root-extra
RUN cd /tmp/root-extra && makepkg -sri --needed --noconfirm

# re-install Pythia to link to ROOT correctly
RUN cd /tmp/pythia && makepkg -Csrif --asdeps --needed --noconfirm
User root
RUN pacman -U --asdeps --noconfirm /tmp/pythia/pythia-8.2.35-5-x86_64.pkg.tar.xz

## Clean up
User root
# remove build dirs
RUN rm -rf /tmp/libafterimage /tmp/unuran /tmp/cern-vdt /tmp/xrootd /tmp/pythia /tmp/openblas-lapack /tmp/root-extra

# remove unneeded system files
RUN rm -f \
      /var/cache/pacman/pkg/* \
      /var/lib/pacman/sync/* \
      /etc/pacman.d/mirrorlist.pacnew

# remove pacman rights of non-root user
RUN sed -i '/docker-user ALL=NOPASSWD:\/usr\/bin\/pacman/d' /etc/sudoers

# go back to regular user
User docker-user

# run bash at login
CMD ["/bin/bash"]
