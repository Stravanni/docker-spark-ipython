# docker-spark-ipython

To run a container with a shared folder (e.g. ~/Desktop/localFolder), listening on the port 8888.
The *localFolder* is located on the desktop and you can use it to share file with the virtual machines, ipython notebook included.

```
docker run -d -p 8888:8888 -v ~/Desktop/localFolder/:/notebooks --name pyspark stravanni/ipython-spark
```

- `-d` deamon mode
- `-p` posrt
- `-v` volume
- `--name` give a name to the containers

### Launch the notebook
Open the brawser at [localhost:8888](localhost:8888)

If you are on Mac, remember that the actual VB ip can be finded with `boot2docker ip`.
While, if you want connect to the `localhost` you need the following port forwarding for VBox:

(e.g. ports from 8880 to 8890)
```
for i in {8880..8890}; do
VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
done
```

To get info about the virtual machine where the containers run:
```
boot2docker info
```
To change the memory of the VirtualMachine (i.e. VBox)
```
BoxManage modifyvm boot2docker-vm --memory 4096
```

### Manage containers
- `docker ps` shows acrive conainers
- `docker ps -a` shows all containers
- `docker restart CONTAINER-ID` restarts a container
- `docker stop 'docker ps -aq'` stops all containers
- `docker rm 'docker ps -aq'` removes all conainers

### IPython and PySpark
Launching the container the first command issued is:
```
IPYTHON_OPTS="notebook --no-browser --ip=0.0.0.0 --port 8888" /usr/local/spark/bin/pyspark
```
The IPython notebook will already have the *sparkContext* variable `sc`.
Write `sc.version` to see what verison is loaded.