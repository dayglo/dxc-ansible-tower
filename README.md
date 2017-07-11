# DXC configured Ansible Tower image

Before you start you need ansible-tower:3.1.1 built from https://github.com/dayglo/ansible-tower-docker

### 1. Get and build the repo
```
git clone https://github.com/dayglo/dxc-ansible-tower.git
cd ansible-tower
./build.sh
```

### 2. Get a license

Go here and get a licence file.

http://www.ansible.com/license

Save it into license.txt somewhere.


```
# change git url to the url of a repo with a playbook.yml with instructions for configuring tower
export TOWER_SETUP_PLAYBOOK_GIT_URL=https://github.com/dayglo/synergy-poc-setup 

docker run -d \
	-p 443:443 \
	--name tower \
	-v /wherever/you/put/your/license/file/license.txt:/etc/tower/license \
	--privileged \
	dayglo/dxc-ansible-tower:3.1.1.1

```

If you want to run playbooks against oneview, set the credentials and host like so:- 

```
docker run -d \
	-p 443:443 \
	--name tower \
	-v /wherever/you/put/your/license/file/license.txt:/etc/tower/license \
	--privileged \
	-e ONEVIEWSDK_IP=<Oneview IP address> \
	-e ONEVIEWSDK_USERNAME=<Oneview username> \
	-e ONEVIEWSDK_PASSWORD=<Oneview password> \
	dayglo/dxc-ansible-tower:3.1.1.1

```


