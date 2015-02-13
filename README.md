# docker_cron_ssh

# Here: have a docker container that has ssh and cron inside

Build the image using:

$ sudo docker build -t wip_container .  
Run a wip_container container  
Then run it. You can then use docker port to find out what host port the container's port 22 is mapped to:  

```
$ sudo docker run -d -P --name myrun wip_container
$ sudo docker port wip_container 22
0.0.0.0:34211
```
And now you can ssh as root on the container's IP address (you can find it with docker inspect) 
or on port 34211 of the Docker daemon's host IP address 
(ip address or ifconfig can tell you that) or localhost if on the Docker daemon host:

```
$ ssh root@172.17.0.22 -p 34211
```
The password is ``somepassword``

