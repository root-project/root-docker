# start with ArchLinux with base & base-devel
FROM archlinux:latest

# set maintaner label
LABEL maintainer.name="Konstantin Gizdov"
LABEL maintainer.email="arch@kge.pw"

ARG compute_type

# work in /tmp
WORKDIR /tmp

## Configure initial system (lines 25-36)
# enable US, DE, GB system locales
# set default locale to United States
# enable gnupg for root user (for pacman)
# update keys for package signing
# make non-root user: docker-user
# update core databases
## Install packages (lines 37 - 40)
# install CERN`s ROOT (incl. all optional dependencies)
# make Git available as well
## Clean up (lines 41)
# remove unneeded system files
RUN sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=en_US.UTF-8' > /etc/locale.conf
RUN mkdir -p /root/.gnupg
RUN touch /root/.gnupg/dirmngr_ldapservers.conf
RUN dirmngr
RUN pacman-key --init
RUN pacman-key --populate archlinux
RUN useradd -ms /bin/bash docker-user
RUN pacman -Syu --noconfirm
RUN pacman --noconfirm --needed -S bash gawk gcc git freetype2 cern-vdt \
      cfitsio gcc-fortran libmariadbclient libxml2 openssl postgresql-libs \
      pythia8 fastjet hepmc lhapdf sqlite tcsh unuran vc z3 xrootd \
      $(if [[ $compute_type =~ [cC][uU][dD][aA] ]]; then echo root-cuda; else echo root; fi;)
RUN  rm -f /var/cache/pacman/pkg/* /var/lib/pacman/sync/* /etc/pacman.d/mirrorlist.pacnew

# go back to regular user
USER docker-user

CMD ["root", "-b"]
