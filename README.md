## Getting started

The ROOT team provides several Docker images. In order to run containers, you must [have Docker installed](https://www.docker.com/community-edition#/download).
You can start a container by running the following command in your terminal which will start the latest stable release of ROOT:
`docker run --rm -it rootproject/root`
Note that the `--rm` flag tells Docker to remove the container, together with its data, once it is shut down. In order to persist data, it is recommended to mount a directory on the container. For example, to mount your home directory on Linux and Mac, run:
`docker run --rm -it -v ~:/userhome --user $(id -u) rootproject/root`
On Windows, you have to specify the full path to your user directory:
`docker run --rm -it -v C:\\Users\\Username:/userhome rootproject/root`

The `-v` option tells Docker to mount the home directory (`~`) to `/userhome` in the container. `--user $(id -u)` signs us in with the same userid as in the host in order to allow reading/writing to the mounted directory. This is not necessary on Windows. Mac and Windows users does however have to mark the drives or areas they want to mount as shared in the Docker application under settings.

[Configuring Docker for Windows Shared Drives / Volume Mounting with AD](https://blogs.msdn.microsoft.com/stevelasker/2016/06/14/configuring-docker-for-windows-volumes/)
[More about mounting host directories in the container.](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume)

### Graphics (Optional)
##### Windows
To enable graphics, you must have [Xming](https://sourceforge.net/projects/xming/) installed. Make sure Xming is whitelisted in the Windows firewall when prompted. After installing Xming, white-list the IP-address of the Docker containers in Xming by running the following command in PowerShell as administrator: 
``Add-Content 'C:\Program Files (x86)\Xming\X0.hosts' "`r`n10.0.75.2"`` 
Restart Xming and start the container with the following command: 
`docker run --rm -it -e DISPLAY=10.0.75.1:0 rootproject/root`

##### Linux
To use graphics, make sure you are in an X11 session and run the following command: 
`docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm -it --user $(id -u) rootproject/root`

##### OSX
To use graphics on OSX, make sure [XQuarz](https://www.xquartz.org/) is installed. After installing, open XQuartz, and go to XQuartz, Preferences, select the Security tab, and tick the box "Allow connections from network clients". Then exit XQuarz. Afterwards, open a terminal and run the following commands:
`ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')`
This will grab your IP address on the local network. Run `echo $ip` to make sure it was successfull. If nothing is displayed, replace `en0` with `en1` or a higher number in the command.
`xhost + $ip`
This will start XQuartz and whitelist your local IP address. Finally, you can start up ROOT with the following command:
`docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 rootproject/root`

## Tags

ROOT Docker images come in various flavours. You can see all available tags [on Docker Hub](https://hub.docker.com/r/rootproject/root/tags).

## Examples
[See GitHub for example Dockerfiles.](https://github.com/root-project/docker-examples)

