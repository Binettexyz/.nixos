{ config, pkgs, ... }:
{
  nix = {
#    package = pkgs.nixFlakes;
    useSandbox = true;

    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

      # cmd: nixos-help
#    documentation.nixos.enable = true;

    environment.etc.current-nixos-config.source = ./.;

    system = {
      autoUpgrade = {
        enable = true;
        allowReboot = false;
        channel = https://nixos.org/channels/nixos-21.11;
      };
    };


}
