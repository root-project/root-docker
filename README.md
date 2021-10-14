## Quick reference

Maintained by: [the ROOT team](https://root.cern/) and collaborators

Where to get help: [the ROOT forum](https://root-forum.cern.ch/)

## Supported tags and respective Dockerfile links

* [`latest`](https://github.com/root-project/root-docker/blob/6.24.06-ubuntu20.04/ubuntu/Dockerfile) -> [`6.24.06-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.24.06-ubuntu20.04/ubuntu/Dockerfile), [`6.24.02-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.24.02-ubuntu20.04/ubuntu/Dockerfile), [`6.24.00-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.24.00-ubuntu20.04/ubuntu/Dockerfile), [`6.22.08-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.22.08-ubuntu20.04/ubuntu/Dockerfile), [`6.22.06-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.22.06-ubuntu20.04/ubuntu/Dockerfile), [`6.22.02-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.22.02-ubuntu20.04/ubuntu/Dockerfile), [`6.22.00-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.22.00-ubuntu20.04/ubuntu/Dockerfile), [`6.20.08-ubuntu20.04`](https://github.com/root-project/root-docker/blob/6.20.08-ubuntu20.04/ubuntu/Dockerfile)
* [`6.24.06-conda`](https://github.com/root-project/root-docker/blob/6.24.06-conda/conda/Dockerfile), [`6.24.02-conda`](https://github.com/root-project/root-docker/blob/6.24.02-conda/conda/Dockerfile), [`6.24.00-conda`](https://github.com/root-project/root-docker/blob/6.24.00-conda-3/conda/Dockerfile), [`6.22.08-conda`](https://github.com/root-project/root-docker/blob/6.22.08-conda/conda/Dockerfile), [`6.22.06-conda`](https://github.com/root-project/root-docker/blob/6.22.06-conda/conda/Dockerfile), [`6.22.02-conda`](https://github.com/root-project/root-docker/blob/6.22.02-conda/conda/Dockerfile), [`6.22.00-conda`](https://github.com/root-project/root-docker/blob/6.22.00-conda/conda/Dockerfile)
* [`6.24.06-arch`](https://github.com/root-project/root-docker/blob/6.24.06-arch/arch/Dockerfile), [`6.24.02-arch`](https://github.com/root-project/root-docker/blob/6.24.02-arch/arch/Dockerfile), [`6.24.00-arch`](https://github.com/root-project/root-docker/blob/6.24.00-arch/arch/Dockerfile), [`6.22.06-arch`](https://github.com/root-project/root-docker/blob/6.22.06-arch/arch/Dockerfile), [`6.22.02-arch`](https://github.com/root-project/root-docker/blob/6.22.02-arch/arch/Dockerfile), [`6.22.00-arch`](https://github.com/root-project/root-docker/blob/6.22.00-arch/conda/Dockerfile), [`6.20.06-arch`](https://github.com/root-project/root-docker/blob/6.20.06-arch/arch/Dockerfile)
* [`6.22.08-fedora34`](https://github.com/root-project/root-docker/blob/6.22.08-fedora34/fedora/Dockerfile)
* [`6.22.06-fedora33`](https://github.com/root-project/root-docker/blob/6.22.06-fedora33/fedora/Dockerfile)
* [`6.22.02-fedora32`](https://github.com/root-project/root-docker/blob/6.22.02-fedora32/fedora/Dockerfile), [`6.22.00-fedora32`](https://github.com/root-project/root-docker/blob/6.22.00-fedora32/fedora/Dockerfile), [`6.20.06-fedora32`](https://github.com/root-project/root-docker/blob/6.20.06-fedora32/fedora/Dockerfile)
* [`6.22.08-centos7`](https://github.com/root-project/root-docker/blob/6.22.08-centos7/centos7/Dockerfile), [`6.22.02-centos7`](https://github.com/root-project/root-docker/blob/6.22.02-centos7/cc7/Dockerfile), [`6.22.00-centos7`](https://github.com/root-project/root-docker/blob/6.22.00-centos7/cc7/Dockerfile)

### Supported C++ standards

Different images provide different compilers and a ROOT installation built with different C++ standards.

The `latest` tag and the `*-ubuntu20.04` tags (starting from ROOT 6.24) have C++14 support: their ROOT is compiled with that C++ standard.

Tags `*-arch`, `*-conda` and `*-fedora34` have C++17 support.

Tags `*-fedora3[2,3]` have C++14 support.

Tags `*-ubuntu20.04` (up to ROOT 6.22) and `*-centos7` come with ROOT compiled with C++11 support.

## Getting started

The ROOT team provides several Docker images. In order to run containers, you must [have Docker installed](https://www.docker.com/community-edition#/download).
You can start a container by running the following command in your terminal which will start the latest stable release of ROOT:
```
docker run --rm -it rootproject/root
```
Note that the `--rm` flag tells Docker to remove the container, together with its data, once it is shut down. In order to persist data, it is recommended to mount a directory on the container. For example, to mount your home directory on Linux and Mac, run:
```
docker run --rm -it -v ~:/userhome --user $(id -u) rootproject/root
```
On Windows, you have to specify the full path to your user directory:
```
docker run --rm -it -v C:\\Users\\Username:/userhome rootproject/root
```

The `-v` option tells Docker to mount the home directory (`~`) to `/userhome` in the container. `--user $(id -u)` signs us in with the same userid as in the host in order to allow reading/writing to the mounted directory. This is not necessary on Windows. Mac and Windows users does however have to mark the drives or areas they want to mount as shared in the Docker application under settings.

[Configuring Docker for Windows Shared Drives / Volume Mounting with AD](https://blogs.msdn.microsoft.com/stevelasker/2016/06/14/configuring-docker-for-windows-volumes/)
[More about mounting host directories in the container.](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume)

### Enabling graphics

##### Linux
To use graphics, make sure you are in an X11 session and run the following command:

```
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm -it --user $(id -u) rootproject/root root
```

On some platforms (e.g., Arch Linux) connections to the X server must be allowed explicitly by executing `xhost local:root` or an equivalent command (see e.g. [this page](https://wiki.archlinux.org/index.php/Xhost) for more information on `xhost` and its possible security implications).

##### OSX
To use graphics on OSX, make sure [XQuarz](https://www.xquartz.org/) is installed. After installing, open XQuartz, and go to XQuartz, Preferences, select the Security tab, and tick the box "Allow connections from network clients". Then exit XQuarz. Afterwards, open a terminal and run the following commands:
```
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
```
This will grab your IP address on the local network. Run `echo $ip` to make sure it was successfull. If nothing is displayed, replace `en0` with `en1` or a higher number in the command.
```
xhost + $ip
```
This will start XQuartz and whitelist your local IP address. Finally, you can start up ROOT with the following command:
```
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 rootproject/root root
```

##### Windows
To enable graphics, you must have [Xming](https://sourceforge.net/projects/xming/) installed. Make sure Xming is whitelisted in the Windows firewall when prompted. After installing Xming, white-list the IP-address of the Docker containers in Xming by running the following command in PowerShell as administrator: 
``Add-Content 'C:\Program Files (x86)\Xming\X0.hosts' "`r`n10.0.75.2"`` 
Restart Xming and start the container with the following command: 
```
docker run --rm -it -e DISPLAY=10.0.75.1:0 rootproject/root
```

## Examples
[See GitHub for example Dockerfiles.](https://github.com/root-project/docker-examples)
