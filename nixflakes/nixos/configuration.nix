# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shan = {
    isNormalUser = true;
    description = "Immanuel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  neovim
  brave
  kitty
  bemenu
  nemo
  file-roller
  gnome-disk-utility
  waypaper
  vscode
  blueman
  networkmanagerapplet
  xdg-desktop-portal-wlr
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  xdg-desktop-portal
  wireguard-tools
  swaybg
  xdg-user-dirs
  home-manager
  swayidle
  ntfs3g 
  mtools
  dosfstools
  virt-manager
  udisks
  udiskie
  usermount
  mpvpaper
  unzip
  unar
  brightnessctl
  bitwarden-desktop
  mission-center
  polkit_gnome
  gnome-keyring
  nwg-look
  fastfetch
  sway-contrib.grimshot
  zsh
  wlsunset
  hugo
  git
  obsidian
  motrix
  cheese




  # Themes
  tokyonight-gtk-theme
  andromeda-gtk-theme


  # Icons
  tela-icon-theme
  tela-circle-icon-theme

  ];

  #Fonts
  fonts.packages = with pkgs; [
  fira-code-nerdfont
  font-awesome_5
  jetbrains-mono
  ];


  # Filesystem

  fileSystems."/mnt/workspace" = {
    device = "/dev/disk/by-uuid/d8d323ef-d4ce-4cea-9e02-56767623795d";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-name=workspace" "x-gvfs-icon=drive-harddisk"  ];
  };

  fileSystems."/mnt/linuxfiles" = {
    device = "/dev/disk/by-uuid/D812E56A12E54DD6";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "nofail" "uid=1000" "gid=1000" "x-gvfs-show" "x-gvfs-name =linuxfiles" "x-gvfs-icon=drive-harddisk"  ];
  }; 

  fileSystems."/mnt/development" = {
    device = "/dev/disk/by-uuid/5672119772117CC5";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "nofail" "uid=1000" "gid=1000" "x-gvfs-show" "x-gvfs-name=development" "x-gvfs-icon=drive-harddisk"  ];
  }; 

    fileSystems."/mnt/virtualmachines" = {
    device = "/dev/disk/by-uuid/1c978fde-b959-44de-be5e-c38914bb6a27";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-show" "x-gvfs-name=virtualmachines" "x-gvfs-icon=drive-harddisk"  ];
  };


  # For Electron apps

  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  # XDG portal

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
    ];

  };

  # Hyprland

  programs.hyprland = {
    enable = true;
    # withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  }; 
  

  # Waybar

  programs.waybar.enable = true;


  # NTFS

  boot.supportedFilesystems = [ "ntfs" ];


  # Bluetooth

  hardware.bluetooth.enable = true;


  # Flakes

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  

  # Virt manager

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["shan"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  

  # udisks

  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
  services.udisks2.mountOnMedia = true;

  # Bluetooth

  # hardware.bluetooth.enable = false;
  services.blueman.enable = false;


  # Systemd service for polkit_gnome

   systemd = {
   user.services.polkit-gnome-authentication-agent-1 = {
   description = "polkit-gnome-authentication-agent-1";
   wantedBy = [ "graphical-session.target" ];
   wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
   };
   };


  # VMware

  virtualisation.vmware.host.enable = true;

  # Default Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;





  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
