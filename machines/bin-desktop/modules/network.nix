{ config, pkgs, lib, ... }: {

  networking = {
    hostName = "bin-laptop";
    enableIPv6 = false;
    useDHCP = false;
    nameservers = [ "94.140.14.14" "94.140.15.15" ];
    networkmanager.enable = false;
    firewall = {
      enable = lib.mkForce true;
      interfaces = {
        wlp3s0 = {
          allowedTCPPorts = [ 22 9091 ];
          allowedUDPPorts = [];
        };
        enp0s25 = {
          allowedTCPPorts = [ 22 9091 ];
          allowedUDPPorts = [];
        };
      };
    };

      # networkManager
#   wireless.enable = false;
#   networkmanager = {
#     enable = true;
#     wifi.powersave = true;
#    };

      # wpa_supplicant
    interfaces.wlp3s0.useDHCP = true;
    wireless = {
      enable = true;
      interfaces = [ "wlp3s0" ];
      userControlled.enable = true;
      networks = {
          # home
        "DD-WRT" = {
          priority = 0;
          pskRaw = "ecae0b81eb975c57daa6222e7cf2278fd055f6172a7bfe64cf8340c620814364";
        };
          # work
        "FONDATIONHBM" = {
          priority = 1;
          pskRaw = "6df6c695105bc76306832ba0643f9de718f72d8886e072605f5ef256f8df5542";
        };

          # girlfriend's
        "VIDEOTRON4142" = {
          priority = 2;
          pskRaw = "dbb4484b30281f5bafd84d6030f4863bdd7709ca7fce550cdfc2bfda69b31642";
        };
          # phone's hotspot
        "bin-hotspot" = {
          hidden = true;
          priority = 3;
          pskRaw = "2855045c3fb78c87d82fca5761710f259cf7b4f20c5f022c5937349b9bf71707";
        };

      };
    };
  };

      # enable openssh daemon
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      startWhenNeeded = true;
    };

  programs = {
#    mtr.enable = true;
#    gnupg.agent = {
#      enable = true;
#      enableSSHSupport = true;
#    };
    tmux = {
      enable = true;
    };
  };

}