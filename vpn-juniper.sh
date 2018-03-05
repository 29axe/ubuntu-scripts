#!/bin/sh

# install the following packages
sudo apt install -y network-manager-openvpn network-manager-vpnc network-manager-openconnect

# for gnome install also
sudo apt install -y network-manager-openvpn-gnome network-manager-vpnc-gnome network-manager-openconnect-gnome

# reload all new or changed systemctl units
sudo systemctl daemon-reload

# restart network manager
sudo service network-manager restart

# to connect to juniper go to settings > network > vpn > add
# choose : Cisco Anyconnect Compatible VPN (openconnect)
echo "In order to connect to a juniper network, please go to settings > network > vpn > add > \"Cisco Anyconnect Compatible VPN (openconnect)\" and fill the form. Hit \"Add\" and you should be good to go."

