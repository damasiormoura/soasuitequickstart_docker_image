# Running Container

## Starting Jdeveloper

### First run (Create the container)
$ docker run --name my-soa-environment -ti --env DISPLAY=host.docker.internal:0.0 -v D:\HostSharedFolder:/mnt/host soaquickstart:12.2.1.4

NOTES: If you are using a Windows Host, you need to install an X Terminal Server like Xming (http://www.straightrunning.com/XmingNotes/index.php).
       Substitute "D:\HostSharedFolder" for a local host directory to container have access. You can use this folder as persistent store for your project files.

### Start container if not first time (Launch Jdeveloper)
$ docker start my-soa-environment

### Start other application from the container. Examples:

#### bash
$ docker exec -it my-soa-environment bash 

#### config new or update Weblogic domains
$ docker exec -it my-soa-environment oracle_common/common/bin/config.sh

#### any other command
$ docker exec -it my-soa-environment <your_command_here>

#### stop container
$ docker stop my-soa-environment

NOTE: If you close Jdeveloper, it will stop container, because it is the root process of the container defined in Dockerfile.


