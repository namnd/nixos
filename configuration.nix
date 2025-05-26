{ pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = builtins.fetchTarball "https://github.com/namnd/dwm/tarball/master";
    };
  };

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services.xserver.xkb = {
    layout = "au";
    variant = "";
    # options = "caps:swapescape"; # only enable if not using external keyboard
  };

  services.clipmenu.enable = true;

  users.users.namnguyen = {
    isNormalUser = true;
    description = "Nam Nguyen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.ssh.startAgent = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dmenu
    arandr
    fastfetch
    ghostty
    git
    firefox
    xclip
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

}

