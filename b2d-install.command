# make the ".boot2docker" config folder  at user's home folder and setup the "profile" file there
mkdir ~/.boot2docker

# create bott2docker "profile" file
echo "#VM_NAME=boot2docker-vm
#VBM=VBoxManage

#DOCKER_PORT=4243
#SSH_HOST_PORT=2022

VM_DISK=~/.boot2docker/boot2docker.vmdk
#VM_DISK_SIZE=40000

#VM_MEM=1024

BOOT2DOCKER_ISO=~/.boot2docker/boot2docker.iso
# " > ~/.boot2docker/profile
#

# create and set "bin" folder path and docker environment in .bash_profile
mkdir ~/bin
cat ./bash_profile >> ~/.bash_profile

# download latest boot2docker OS script version
curl https://raw.github.com/steeve/boot2docker/master/boot2docker > ~/bin/boot2docker
# Mark it executable
chmod +x ~/bin/boot2docker

# run boot2docker init command
~/bin/boot2docker init

# download latest docker OS X client
curl -o ~/bin/docker http://get.docker.io/builds/Darwin/x86_64/docker-latest
# Mark it executable
chmod +x ~/bin/docker

# create short "b2d" symbolic link to "boot2docker", it makes easier to use via command line
ln -s ~/bin/boot2docker ~/bin/b2d

