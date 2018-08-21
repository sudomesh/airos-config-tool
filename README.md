# airos-config-tool
peoplesopen configuration automater for AirOS

Note: we discourage people from putting more effort into this repo than neccessary, since it is highly dependent on closed hardware and proprietary firmware.

## Usage

Configure network settings to: 
```
IP address - 192.168.1.9, 
Subnet mask - 255.255.255.0  
Gateway - 192.168.1.1
```

Reset Ubiquiti device to default settings by holding reset button for 15-20 seconds.  

```
./config.sh <device-nickname>
```

Device nicknames are as follows,
```
Rocket M5 - RM5
Nanobridge M5 - NB5
Nanostation M5 - NS5
Nanobeam M5 - NBE
```

To test that config was successful, set network settings to: 
```
IP address - 100.65.254.9 
Subnet mask - 255.255.255.192
Gateway - 100.64.0.1
```
And try going to http://100.65.254.4 and logging in with default sudomesh username/pw.

## Notes
It maybe be good to up/downgrade the firmware to pre-5.6, since that is compatible with OpenWrt and will be easier to change if we switch to sudowrt or LibreMesh. Here are download links,  
[XW 5.5.10](http://dl.ubnt.com/firmwares/XW-fw/v5.5.10/XW.v5.5.10-u2.28005.150723.1358.bin)  
[XM 5.5.11](http://dl.ubnt.com/firmwares/XN-fw/v5.5.11/XM.v5.5.11.28002.150723.1344.bin)  

Uploading firmware instructions, and various other documentation, can be found at https://sudoroom.org/wiki/Mesh/Flashing_extender_nodes
