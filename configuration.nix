# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#     <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "flpwnix"; # Define your hostname.
 #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  #services.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Display and Window Manager
  services.displayManager.sddm.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.displayManager.sddm.theme = "${import ./sddm-theme.nix {inherit pkgs; }}";

  # Configure keymap in X11
  services.xserver.xkb.variant = "";
  services.xserver.xkb.layout  = "br";

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flpwnix = {
    isNormalUser = true;
    description = "Felipe Wlodkowski";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

# home-manager.users.flpwnix = { pkgs, ... }: {
#   home.packages = [ pkgs.atool pkgs.httpie ];
#   programs.bash.enable = true;
#   home.stateVersion = "24.05";
# };
# home-manager.useGlobalPkgs = true;
# home-manager.useUserPackages = true;


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # environment variables
  environment.variables = {
    DB_USERNAME_eventicket = "eventicket_user";
    DB_PASSWORD_eventicket = "root";
    DB_URL_eventicket = "jdbc:postgresql://localhost:5432/eventicket";

    

    EmailFrom = "vtorlopescontato@gmail.com";
    SenhaGmail = "xspgiyobvsqlcyhe";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fastfetch
    htop
    git
    kitty # terminal emulator
    alacritty # terminal emulator
    flameshot # screenshots    
    neovim
    slock
    st
    dmenu
    feh
    gcc # C compiler
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    pipes-rs
   #mysql84
    postman
    yazi # cli file manager
    docker
    docker-compose
    fzf
    maven
    jdk17
    lua
    tmux
    bat
    python3
    unzip
    xclip # share nvim clipboard
    lombok # java development
    jetbrains.idea-community-src
    lazydocker
    usql # db cli
    dbeaver-bin
    arduino-ide
    postgresql
    pgadmin4
    discord
    exiftool
    burp
    python312Packages.pip
    go
    maltego
    file
    unrar
    xorg.xrandr
    qrencode
    zbar
    holehe
    nodejs_22
    nodePackages."@angular/cli"
    nodePackages."vscode-langservers-extracted"
    vscode-extensions.angular.ng-template
    lazygit
    maim

  ];

  # mysql
  services.mysql = {
    enable = true;
    package = pkgs.mysql84; # or your desired MySQL version
  };

  # postgresql
  services.postgresql.enable = true;

  # dwm custom sources
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
    src = /etc/nixos/dwm;
    nativeBuildInputs = [ pkgs.pkg-config ] ++ (oldAttrs.nativeBuildInputs or []);
    patches = [
      (pkgs.fetchpatch {
        url = "https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-6.2.diff";
        hash = "sha256-s1FMbEjDHXYsu0VP2cidyfU1tOp8d7HCZ58rC7xm4Jc=";
      })
     #(pkgs.fetchpatch {
     #  url = "https://dwm.suckless.org/patches/attachbelow/dwm-attachbelow-6.2.diff";  
     #  hash = "sha256-Apy+bRQG/MgnJYgrT1aJ6tMrSaK89Ud1nFA/G8NdyqI=";  
     #})
    ];
  });

  # picom 
  services.picom.enable = true;

  # openssh
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.X11Forwarding = true;

  # fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];  

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
   networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  # Enabling flakes
 # nix.settings.experimental-features = [ "nix-command" "flakes"];

}

