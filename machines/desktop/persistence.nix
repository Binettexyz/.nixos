{ config, ... }: {

  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/lib"
      "/var/log"
      "/mounts"
      "/root"
      "/srv"
    ];
  };

  home-manager.users.binette = {
    imports = [ <impermanence/home-manager.nix> ];
    home.persistence."/nix/persist/home/binette" = {
      removePrefixDirectory = false;
      allowOther = true;
      directories = [
        ".config/discordcanary"
        ".config/powercord"
        ".config/tidal-hifi"
        ".steam"
      ];

      files = [
        ".nvidia-settings-rc"
      ];
    };
  };

}
