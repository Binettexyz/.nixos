{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.profiles.core;
in
{
  imports = [
    ./packages.nix
    ./tty-login.nix
  ];

  options.modules.profiles.core = {
    enable = mkOption {
      description = "Enable core options";
      type = types.bool;
      default = true;
    };

    bluetooth.enable = mkOption {
      description = "Enable bluetooth";
      type = types.bool;
      default = false;
    };

    wifi.enable = mkOption {
      description = "Enable wifi";
      type = types.bool;
      default = false;
    };

    print.enable = mkOption {
      description = "Enable print";
      type = types.bool;
      default = false;
    };

    ssd.enable = mkOption {
      description = "Enable enable fstrim";
      type = types.bool;
      default = false;
    };

    virtmanager.enable = mkOption {
      description = "Enable enable fstrim";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) (mkMerge [
    ({
        # Set environment variables
      environment.variables = {
        NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
        PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
        EDITOR = "nvim";
        TERMINAL = "st";
        BROWSER = "brave";
      };

        # Nix settings, auto cleanup and enable flakes
      nix = {
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 4d";
        };
        extraOptions = ''
          keep-outputs = true
          keep-derivations = true

        '';
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
          auto-optimise-store = true;
          allowed-users = [ "binette" ];
        };
      };

        # Get rid of defaults packages
      environment.defaultPackages = [ ];

          # Fonts
      fonts = {
        fontDir.enable = true;
        fontconfig = {
          enable = true;
          includeUserConf = true;
          cache32Bit = true;
          defaultFonts = {
            emoji = [ "Noto Color Emoji" ];
            sansSerif = [
              "JetBrainsMono Nerd Font Mono"
            ];
            monospace = [
#              "FiraCode Nerd Font Mono"
#              "Iosevka Term"
              "FantasqueSansMono Nerd Font Mono"
#              "mononoki Nerd Font Mono"
            ];
          };
        };

        fonts = with pkgs; [
            # Emoji/Icons
          font-awesome
          noto-fonts-emoji
          material-design-icons
          material-icons
    
            # Fonts
          (nerdfonts.override {
            fonts = [
              "Iosevka"
              "FiraCode"
              "JetBrainsMono"
              "Mononoki"
              "FantasqueSansMono"
            ];
          })
            # LaTeX
          lmodern
        ];
      };
      environment.systemPackages = with pkgs; [ faba-mono-icons ];

      services.openssh = {
        enable = true;
        allowSFTP = true;
        ports = [ 704 ];
        startWhenNeeded = true;
        settings = {
          kbdInteractiveAuthentication = false;
          passwordAuthentication = false;
          permitRootLogin = "no";
          X11Forwarding = false;
        };
        extraConfig = ''
          UsePam no
          AllowTcpForwarding yes
          AllowAgentForwarding no
          AllowStreamLocalForwarding no
          AuthenticationMethods publickey
        '';
      };

      services.tailscale.enable = true;

        # Boot settings: clean /tmp, silent boot etc.
      boot = {
          # Mount tmpfs on /tmp
        tmpOnTmpfs = lib.mkDefault true;  
        cleanTmpDir = true;

          # Silent boot
        initrd.verbose = false;
        consoleLogLevel = 0;
        kernelParams = [ "quiet" "udev.log_level=3"];

        loader = {
          timeout = 1;
          };
      };

        # X servers
      services.xserver = {
        enable = true;
        layout = "us";
          # enable startx
        displayManager.startx.enable = lib.mkDefault true;
          # disable xterm
        desktopManager.xterm.enable = false;
      };

        # Locales
      time.timeZone = "Canada/Eastern";
      location = {
        provider = "manual";
        latitude = 45.30;
        longitude = -73.35;
      };
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
      };

        # User
      users = {
        defaultUserShell = lib.mkForce pkgs.zsh;
        mutableUsers = false;
        groups.binette.gid = 1000;
        users.binette = {
          uid = 1000;
          isNormalUser = true;
          createHome = true;
          home = "/home/binette";
          group = "binette";
          extraGroups = [ "wheel" "binette" "users" "audio" "video" "docker" ];
          hashedPassword =
            "$6$89SIC2h2WeoZT651$26x4NJ1vmX9N/B54y7mc5pi2INtNO0GqQz75S37AMzDGoh/29d8gkdM1aw6i44p8zWvLQqhI0fohB3EWjL5pC/";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxsgVkgA8fBxOOsL8WmqGa1hAzYgl7YNz/OvLiDq5fO binette@desktop"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3Fo8FZrrTYGqIH84r67dkmSIxcOD3DhJrIJe6ndJ0z binette@t440p"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWeBglzVFzHXfNq/T+Hu31ukZ3iN6I5UXBpxIN7MRAP binette@x240"
          ];
        };
        users.root = {
          hashedPassword =
            "$6$rxT./glTrsUdqrsW$Wzji63op8yTEBoIEcWBc26KOlFJtqx.EKpsGV1A2bQT9oB1JKtrlfdArYICc/Ape.msHcj6ObyXlmRKTWTC/J.";
        };
      };

        # Networking
      networking = {
        enableIPv6 = false;
        useDHCP = lib.mkDefault false;
        networkmanager.enable = false;
        nameservers = [
#          "100.71.254.90" # adguardhome dns using tailscale.
#          "9.9.9.9"
        ];
        firewall = {
          enable = true;
          allowedTCPPorts = [
            2049 # NFSv4
            53 # dns
          ];
          allowedUDPPorts = [
            config.services.tailscale.port
#            51820 # wireguard
            53 # dns
          ];
          allowPing = false;
            # tailscale
          checkReversePath = "loose";
          trustedInterfaces = [ "tailscale0" ];
        };
      };

        # Security
      security = {
          # prevent replacing the running kernel image
        protectKernelImage = true;
        sudo.enable = false;
        doas = {
          enable = true;
          extraRules = [{ users = [ "binette" ]; noPass = true; keepEnv = true; }];
        };
        acme.acceptTerms = true;
        acme.defaults.email = "binettexyz@proton.me";
      };

      boot.blacklistedKernelModules = [
          # Obscure network protocols
        "ax25"
        "netrom"
        "rose"
          # Old or rare or insufficiently audited filesystems
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "vivid"
        "gfs2"
        "ksmbd"
    #    "nfsv4"
    #    "nfsv3"
        "cifs"
    #    "nfs"
        "cramfs"
        "freevxfs"
        "jffs2"
        "hfs"
        "hfsplus"
        "squashfs"
        "udf"
    #    "bluetooth"
        "btusb"
    #    "uvcvideo" # webcam
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "omfs"
        "uvcvideo"
        "qnx4"
        "qnx6"
        "sysv"
        "ufs"
      ];

        # Hardware
      hardware = {
          # Opengl
        opengl.enable = true;
          # Enable Font/DPI configuration optimized for HiDPI displays
        video.hidpi.enable = true;
      };

        # Needed by home-manager's impermanence
      programs.fuse.userAllowOther = true;

        # Sops-nix password encryption
      sops.defaultSopsFile = ../../../secrets/common.yaml;
      sops.age.sshKeyPaths = [ "/home/binette/.ssh/id_ed25519" ];

      environment.etc = {
        "machine-id".source = "/nix/persist/etc/machine-id";
        "ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
        "ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
        "ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
        "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
      };

        # don't install documentation i don't use
      documentation.enable = true; # documentation of packages
      documentation.nixos.enable = true; # nixos documentation
      documentation.man.enable = true; # manual pages and the man command
      documentation.info.enable = false; # info pages and the info command
      documentation.doc.enable = false; # documentation distributed in packages' /share/doc

      system.stateVersion = "22.05";
    })

    (mkIf cfg.bluetooth.enable {
        # Enable Bluetooth
      hardware.bluetooth.enable = true;
      services.blueman.enable = lib.mkIf (config.services.xserver.enable) true;
      programs.dconf.enable = lib.mkIf (config.services.xserver.enable) true;
    })

    (mkIf cfg.wifi.enable {
        # Enable WIFI
      networking.wireless = {
        enable = true;
        userControlled.enable = true;
        networks = {
            # Home
          "EBOX-2153-5G" = {
            priority = 0;
            auth = ''
	            psk=c44e2f5c7b748c884049cff130ca93a888598868703f6160f7f45c9e3da5e74e
	            proto=RSN
            	key_mgmt=WPA-PSK
            	pairwise=CCMP
            	auth_alg=OPEN
            '';
          };
            # Home
          "EBOX-2153" = {
            priority = 0;
            auth = ''
	            psk=0e6a94029151fb40f2fbb513dd2534b7e7ebdc91edb13419762f0f4f0590f198
	            proto=RSN
            	key_mgmt=WPA-PSK
            	pairwise=CCMP
            	auth_alg=OPEN
            '';
          };
            # CHSLD (work)
          "Loisirs" = {
            priority = 2;
            auth = ''
              psk=ca62593afdd9ec7cac04d7730061da25616f3f883aca43a4245675947acd24fb
              proto=RSN
              key_mgmt=WPA-PSK
              pairwise=CCMP
              auth_alg=OPEN
            '';
          };
        };
      };
    })

    (mkIf cfg.print.enable {
        # Enable Printer
      services.printing.enable = true;
    })

    (mkIf cfg.ssd.enable {
      # swap ram when % bellow is reach (1-100)
    boot.kernel.sysctl = { "vm.swappiness" = 1; };
    services.fstrim.enable = true; # ssd trimming
    })

    (mkIf cfg.virtmanager.enable {
      virtualisation.libvirtd.enable = true;
      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [ virt-manager ];
    })
  ]);

}
