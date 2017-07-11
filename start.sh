#!/bin/bash
#get script path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null
 	
echo $SCRIPTPATH

docker run -d \
	-p 4000:443 \
	--name tower \
	-v "$SCRIPTPATH/license.txt":/etc/tower/license \
	-v tower_certs:/certs \
	-e TOWER_INIT_SCM_URL=https://github.com/dayglo/synergy-poc-setup \
	--restart=always \
	--privileged \
	-e ONEVIEWSDK_IP=$ONEVIEWSDK_IP \
	-e ONEVIEWSDK_USERNAME=$ONEVIEWSDK_USERNAME \
	-e ONEVIEWSDK_PASSWORD=$ONEVIEWSDK_PASSWORD \
	dayglo/dxc-ansible-tower:3.1.1.1

docker logs -f tower