# airos-config-tool
This repo includes:
- peoplesopen configuration automater for AirOS, `config.sh` (and potentially other related scripts)
- Consolidated documentation for how we configure and use AirOS. Please prioritize this repo over the wiki, so we can keep documentation close to related code.

We discourage people from putting more effort into this repo than neccessary, since it is highly dependent on closed hardware and proprietary firmware.

This README provides brief instructions on using `config.sh`.
For information about how we plan AirOS deployments, how to use the AirOS admin app, etc., see [our FAQ](guides/faq.md).

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

To test that config was successful, connect the extender node to port 2 on home node you intend to use it with and connect your computer to the peoplesopen SSID of your home node. Try pinging the extender node's IP address, which is the home node IP plus one (e.g. home node, 100.65.99.193, connects to extender node, 100.65.99.194). You can also try logging into AirOS by opening the extender node's IP address in a web browser.

## Notes
It maybe be good to up/downgrade the firmware to pre-5.6, since that is compatible with OpenWrt and will be easier to change if we switch to sudowrt or LibreMesh. Here are download links,  
[XW 5.5.10](http://dl.ubnt.com/firmwares/XW-fw/v5.5.10/XW.v5.5.10-u2.28005.150723.1358.bin)  
[XM 5.5.11](http://dl.ubnt.com/firmwares/XN-fw/v5.5.11/XM.v5.5.11.28002.150723.1344.bin)  

Uploading firmware instructions, and various other documentation, can be found at https://sudoroom.org/wiki/Mesh/Flashing_extender_nodes
