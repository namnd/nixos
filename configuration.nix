{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.utf8";

  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  users.users.namnguyen = {
    isNormalUser = true;
    description = "Nam Nguyen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8HjC+29D66x0zOMMwrleHKHN4bD5hBmIqKzc3FALQo" ];
 
    packages = with pkgs; [];
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gnumake
    vim
    xclip
  ];
  services.openssh.enable = true;

  system.stateVersion = "23.05";
}
