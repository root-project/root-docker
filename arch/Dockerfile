# start with ArchLinux with base & base-devel
FROM base/devel

# set maintaner label
LABEL maintainer.name="Konstantin Gizdov"
LABEL maintainer.email="arch@kge.pw"

# work in /tmp
WORKDIR /tmp
# copy needed local patch
COPY fix_libafterimage_pkgbuild.patch /tmp/fix_libafterimage_pkgbuild.patch

USER root

## Configure initial system
# set locale to United Kingdom UTF-8
# enable gnupg for root user (for pacman)
# update keys for package signing
# make non-root user
# update core databases
# use all cores in makepkg
# install Git (AUR packages) & freetype2 (required by libAfterImage & ROOT)
RUN sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && echo 'LANG=en_GB.UTF-8' > /etc/locale.conf \
 && mkdir -p /root/.gnupg \
 && touch /root/.gnupg/dirmngr_ldapservers.conf \
 && dirmngr \
 && pacman-key --init \
 && pacman-key --populate archlinux \
 && useradd -ms /bin/bash docker-user \
 && echo "docker-user ALL=NOPASSWD:/usr/bin/pacman" >> /etc/sudoers \
 && pacman -Sy \
 && sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf \
 && pacman --noconfirm --needed -S git freetype2

# change to non-root user for makepkg builds
USER docker-user

# build & install OpenBLAS (openblas-lapack)
RUN git clone https://aur.archlinux.org/openblas-lapack.git /tmp/openblas-lapack \
 && cd /tmp/openblas-lapack \
 && makepkg -sri --asdeps --needed --noconfirm

# install Python NumPy
User root
RUN pacman --noconfirm --needed -S python-numpy
User docker-user

# build & install libAfterImage (libafterimage)
# build & install UNU.RAN (unuran)
# build & install VDT (cern-vdt)
# build & install XRootD (xrootd)
# build & install Pythia (pythia)
# build & install ROOT (root-extra)
# re-install Pythia to link to ROOT correctly
# remove build dirs
RUN git clone https://aur.archlinux.org/libafterimage.git /tmp/libafterimage \
 && cd /tmp/libafterimage && patch -p1 -i /tmp/fix_libafterimage_pkgbuild.patch \
 && cd makepkg -sri --asdeps --needed --noconfirm \
 && git clone https://aur.archlinux.org/unuran.git /tmp/unuran \
 && cd /tmp/unuran && makepkg -sri --asdeps --needed --noconfirm \
 && git clone https://aur.archlinux.org/cern-vdt.git /tmp/cern-vdt \
 && cd /tmp/cern-vdt && makepkg -sri --asdeps --needed --noconfirm \
 && git clone https://aur.archlinux.org/xrootd.git /tmp/xrootd \
 && cd /tmp/xrootd && makepkg -sri --asdeps --needed --noconfirm \
 && git clone https://aur.archlinux.org/pythia.git /tmp/pythia \
 && cd /tmp/pythia && makepkg -sri --asdeps --needed --noconfirm \
 && git clone https://aur.archlinux.org/root-extra.git /tmp/root-extra \
 && cd /tmp/root-extra && makepkg -sri --needed --noconfirm \
 && cd /tmp/pythia && makepkg -Csrif --asdeps --noconfirm \
 && rm -rf /tmp/*

## Clean up
# remove unneeded system files
# remove pacman rights of non-root user
User root
RUN rm -f /var/cache/pacman/pkg/* /var/lib/pacman/sync/* /etc/pacman.d/mirrorlist.pacnew \
 && sed -i '/docker-user ALL=NOPASSWD:\/usr\/bin\/pacman/d' /etc/sudoers

# go back to regular user
User docker-user

# run bash at login
CMD ["/bin/bash"]
