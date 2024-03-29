#!/bin/sh

CONFIG=/etc/nixos/configuration.nix
if ( ! $(cat ${CONFIG} | grep bootstrap > /dev/null) ); then
  sed --in-place '/hardware-configuration\.nix/a ./bootstrap.nix' ${CONFIG}
fi

args=($@)
username=$1
vm_hostname=$2

sed -i "s/username/${username}/g" /etc/nixos/bootstrap.nix
sed -i "s/vm_hostname/${vm_hostname}/g" /etc/nixos/bootstrap.nix

nixos-rebuild switch
