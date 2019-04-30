# start with ArchLinux with base & base-devel
FROM archlinux/base

# set maintaner label
LABEL maintainer.name="Konstantin Gizdov"
LABEL maintainer.email="arch@kge.pw"

# work in /tmp
WORKDIR /tmp

## Configure initial system
# set locale to United Kingdom UTF-8
# enable gnupg for root user (for pacman)
# update keys for package signing
# make non-root user: docker-user
# update core databases
# install Git (AUR packages) & root (incl. optional dependencies)
## Clean up
# remove unneeded system files
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
 && pacman -Sy \
 && pacman --noconfirm --needed -S bash gawk gcc git freetype2 cern-vdt \
      cfitsio gcc-fortran libmariadbclient libxml2 openssl postgresql-libs \
      pythia8 fastjet hepmc lhapdf sqlite tcsh unuran vc xrootd root \
 && rm -f /var/cache/pacman/pkg/* /var/lib/pacman/sync/* /etc/pacman.d/mirrorlist.pacnew

# go back to regular user
User docker-user

# run bash at login
CMD ["/bin/bash"]
