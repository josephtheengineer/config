# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
let
  R-packages = rWrapper.override{ packages = with rPackages; [ rmarkdown ]; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./local-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; 
    loader.grub.enable = false;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    networkmanager.enable = true;

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 22 8888 ];
    firewall.allowedUDPPorts = [ 22 8888 ];

    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  hardware = {
    # Steam 32 bit stuff
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;

    pulseaudio.enable = true;   
  };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      #challengeResponseAuthentication = false;
      #passwordAuthentication = false;
    };
    printing.enable = true;
    printing.drivers = [ pkgs.gutenprint ];
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
    sway.enable = true;
    zsh.enable = true;
    zsh.histFile = "\$HOME/.local/share/zsh/history";
    zsh.ohMyZsh.enable = true;
    zsh.ohMyZsh.theme = "agnoster";
    zsh.promptInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
      export ZDOTDIR="/home/josephtheengineer/.config/zsh"
    '';
    zsh.syntaxHighlighting.enable = true;
    
  };

  nix = {
    gc.automatic = true;
    gc.dates = "12:00";

    extraOptions = ''
      connect-timeout = 10
    '';
  };
  users.users = {
    josephtheengineer = {
      isNormalUser = true;
      home = "/home/josephtheengineer";
      description = "admin";
      extraGroups = [ "wheel" "libvirtd" "sway" "networkmanager" "video" ];
      shell = pkgs.zsh;
      uid = 1000;
    };
    eco = {
      isNormalUser = true;
      home = "/home/eco";
      description = "awesome";
      extraGroups = [];
      shell = pkgs.zsh;
    };
  };

  security.pki.certificates =   [ ''
				NixOS.org
				=========
				------BEGIN CERTIFICATE-------
				HJYTJKHDKJFHKDF768302HJHJG26825JKHG68HJKJJHKGTF
				976KHYTUDKJJHFDSJKFD768030KJH63KJGJGG6383GJKDHJ
				-----END CERTIFICATE--------
				'' 
				];

  time.timeZone = "Australia/Brisbane";
  nixpkgs.config.allowUnfree = true;
  virtualisation.libvirtd.enable = true;
  sound.enable = true;

  # Enable the i3-gaps Desktop Environment.
  #services.xserver = {
    #enable = true;
    #displayManager.startx.enable = true;
    #displayManager.lightdm.enable = false;
    #desktopManager = {
      #default = "none";
      #xterm.enable = false;
    #};
    #windowManager.i3.package = pkgs.i3-gaps;
    #windowManager.i3.enable = true;
    #videoDrivers = [ "nvidia" ];
  #};

  # Virtualbox
  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "josephtheengineer" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    emacs
    htop
    qutebrowser
    neofetch
    gotop
    barrier
    gimp
    nodejs
    arc-theme
    gtk-engine-murrine
    arc-icon-theme
    breeze-gtk
    capitaine-cursors
    powerline-fonts
    zsh
    git
    git-lfs
    gnome3.gnome-disk-utility
    pavucontrol
    roboto-mono
    gnome3.gnome-font-viewer
    xfce.tumbler
    ranger
    python3
    mono
    firefox
    cmake
    clang_39
    unzip
    shutter
    pywal
    nix-prefetch-git
    zip
    stdenv
    bcache-tools
    weechat
    winetricks
    figlet
    lolcat
    i3blocks-gaps
    rtorrent
    libvirt
    virtmanager
    qemu
    networkmanager
    networkmanagerapplet
    cryptsetup
    lvm2
    xorg.xrdb
    iw
    iwd
    qemu_kvm
    capitaine-cursors
    parted
    i3blocks
    ffmpeg
    discord
    adoptopenjdk-bin
    killall
    connman-ncurses
    connmanui
    connman-gtk
    arc-icon-theme
    ppp
    pptp
    rofi
    source-sans-pro
    source-code-pro
    godot
    libreoffice
    system-config-printer
    termite
    w3m
    gnumake
    youtube-dl
    google-chrome
    tigervnc
    conky
    kitty
    fortune
    cowsay
    bsdgames
    gnupg
    mpd
    ncmpcpp
    mpc_cli 
    file
    acpi
    groff
    tectonic
    zathura
    cmatrix
    pandoc
    minecraft
    R-packages
  ];

  # Determines the NixOS release with which your system is to be compatible.
  # You should change this only after the release notes say you should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
