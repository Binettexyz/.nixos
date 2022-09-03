{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.containers.radarr;
in
{
  options.modules.containers.radarr = {
    enable = mkOption {
      description = "Enable radarr services";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) {
    networking.nat.internalInterfaces = [ "ve-radarr" ];
    networking.firewall.allowedTCPPorts = [ 7878 ];

    containers.radarr = {
      autoStart = true;
        # starts fresh every time it is updated or reloaded
  #    ephemeral = true;
  
        # networking & port forwarding
      privateNetwork = false;
  #    hostBridge = "br0";
  #    hostAddress = "192.168.100.11";
  #    localAddress = "192.168.100.21";
  
        # mounts
      bindMounts = {
        "/var/lib/radarr/.config/radarr" = {
          hostPath = "/var/lib/radarr/.config/radarr";
          isReadOnly = false;
        };
        "/media/videos" = {
          hostPath = "/media/videos";
          isReadOnly = false;
        };
        "/media/downloads/torrents" = {
          hostPath = "/media/downloads/torrents";
          isReadOnly = false;
        };
  
      };
  
      forwardPorts = [
  			{
  				containerPort = 7878;
  				hostPort = 7878;
  				protocol = "tcp";
  			}
  		];
  
      config = { config, pkgs, ... }: {
  
        system.stateVersion = "22.05";
        networking.hostName = "radarr";
  
        services.radarr = {
          enable = true;
          user = "radarr";
          group = "radarr";
          openFirewall = true;
        };
  
        systemd.tmpfiles.rules = [
          "d /var/lib/radarr/.config/radarr 700 radarr radarr -"
        ];
      };
    };
  };

}