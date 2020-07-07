# Docker image for CERN's ROOT on ArchLinux

This Docker image is provided for both instructional and usability
purposes. It showcases how one would install and configure a full
installation of CERN's ROOT software package as well as provide
a slim and fully capable Docker image to be used in CI environments.

## Build
There are two variants of this docker image providing either `CPU`
only or with `CUDA` extensions.

You can build the `CPU` only variant with:
`$ docker build -t archlinux-root .`
while the `CUDA` variant needs an extra build argument:
`$ docker build -t archlinux-root . --build-arg compute_type=cuda`

# Pull image
You can pull it from Docker Hub directly:
`$ docker pull kgizdov/archlinux-root:latest  # for the CPU variant`
or:
`$ docker pull kgizdov/archlinux-root:latest-cuda  # for the CUDA variant`

Published [here](https://hub.docker.com/r/kgizdov/archlinux-root)
