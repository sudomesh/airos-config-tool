#!/bin/bash

usage(){
    echo 'Usage:'
    echo '    ./config.sh <device-nickname>'
    echo 'Device nicknames are as follows,'
    echo '    Rocket M5 - RM5'
    echo '    Nanobridge M5 - NB5'
    echo '    Nanostation M5 - NS5'
    echo '    Nanobeam M5 - NBE'
}

if [ -z $1 ]; then
    echo 'No device nickname given'
    usage
    exit 1
fi

# if you get a diffie hellman error, you can use this key 
KEY_ALGO=-oKexAlgorithms=+diffie-hellman-group1-sha1

# Remove 192.168.1.20 from known hosts
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.1.20

# Try pinging the node
PING_SUCCESS=0
for i in 1 2 3 4 5 6 7 8 9 10;
do
  echo "Attempting to ping..."
  if ping -q -c 1 -W 1 192.168.1.20 >/dev/null; then
    PING_SUCCESS=1
    echo "succeeded"
    break
  else
    echo "failed"
  fi
  sleep 5 
done

if [ $PING_SUCCESS == 1 ]; then
  echo "Able to reach device at 192.168.1.20"
else
  echo "Error: Cannot reach device, check network settings"
  exit 1
fi

# Try ssh'ing into the node
SSH_SUCCESS=0
for i in 1 2 3 4 5 6 7 8 9 10;
do
  echo "Attempting to ssh in..."
  if ssh $KEY_ALGO ubnt@192.168.1.20 'cat /etc/board.info' ; then
    SSH_SUCCESS=1
    echo "succeeded"
    break
  else
    echo "failed"
  fi
  sleep 5
done

if [ $SSH_SUCCESS == 1 ]; then
  echo "Able to ssh into device at 192.168.1.20"
else
  echo "Error: Cannot ssh into device, check network settings, or wait longer"
  exit 1
fi

# Choose options 
OPT=$1
if [ $OPT == "RM5" ]; then
    CONFIG=templates/RM5-AP-XW-PON-default.cfg
elif [ $OPT == "NS5" ]; then
    CONFIG=templates/NS5-AP-XM-PON-default.cfg
elif [ $OPT == "NBE" ]; then
    CONFIG=templates/NBE-AP-XW-PON-default.cfg
else
    echo 'Option not recognized'
    usage
    exit 1
fi

cp $CONFIG $CONFIG.bak

read -p "Name for this node: " NAME
read -p "Home node IP Address: " MESHIP

nextip(){
    IP=$1
    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' `echo $IP | sed -e 's/\./ /g'`)
    NEXT_IP_HEX=$(printf %.8X `echo $(( 0x$IP_HEX + 1 ))`)
    NEXT_IP=$(printf '%d.%d.%d.%d\n' `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
    echo $NEXT_IP
}

EXTENDER_NODE_IP_1=$(nextip $MESHIP)
LAST_3_OF_IP=${EXTENDER_NODE_IP_1#*.}

sed -i "s/^resolv.host.1.name=.*/resolv.host.1.name=$NAME/g" $CONFIG 
sed -i "s/^netconf.3.ip=.*/netconf.3.ip=$EXTENDER_NODE_IP_1/g" $CONFIG 
sed -i "s/^wireless.1.ssid=.*/wireless.1.ssid=peoplesopen.net $LAST_3_OF_IP/g" $CONFIG 

# Add model specific configs here, maybe
#if [ $OPT == "RM5" ]; then
    #sed -i "s/^wpasupplicant.profile.1.network.1.ssid=.*/wpasupplicant.profile.1.network.1.ssid=peoplesopen.net $LAST_3_OF_IP/g" $CONFIG 
#fi

scp $KEY_ALGO $CONFIG ubnt@192.168.1.20:/tmp/system.cfg
ssh $KEY_ALGO ubnt@192.168.1.20 << EOF 
cd /tmp/
save
reboot
EOF

mv $CONFIG.bak $CONFIG

exit 
