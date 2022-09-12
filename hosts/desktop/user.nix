{ config, pkgs, lib, inputs, ... }: {

  imports = [
    ../../modules/home/default.nix 
    (inputs.impermanence + "/home-manager.nix")
  ];

  modules = {
    packages = {
      enable = true;
      gaming.enable = true;
    };

    cli = {
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      xdg.enable = true;
      xresources = "gruvbox";
      zsh.enable = true;
    };

    programs = {
     chromium.enable = true;
     dmenu.enable = true;
     gtk.enable = true;
     lf.enable = true;
     librewolf.enable = true;
     mpv.enable = true;
#     mutt.enable = true;
     newsboat.enable = true;
#     nnn.enable = true;
     powercord.enable = true;
     qutebrowser.enable = true;
     slstatus = "desktop";
     st.enable = true;
#     zathura.enable = true;
    };

    services = {
      dunst.enable = true;
      flameshot.enable = true;
      picom.enable = true;
      sxhkd.enable = true;
#      udiskie.enable = true;
    };
  };

  home.packages = with pkgs; [ virt-manager tidal-hifi ];

  home.file.".config/x11/xinitrc".text = ''
    #!/bin/sh

      ### screen ###
    xrandr --output DP-2 --gamma 1 # --set "Broadcast RGB" "Full"

      ### app ###
    pidof -s dunst || setsid -f dunst &	    # dunst for notifications
    slstatus &				    # suckless status bar
    udiskie &				    # automount device daemon
    sxhkd &
    flameshot &
    greenclip daemon &
    nvidia-settings --config=~/.config/.nvidia-settings-rc --load-config-only

      ### Settings ###
#    xrandr --dpi 96
    xsetroot -cursor_name left_ptr &	    # change cursor name
    remaps &				    # remaps capslock with esc
    unclutter &				    # remove mouse when idle

      ### Visual ###
    picom --experimental-backends &
    hsetroot -fill /etc/nixos/.github/assets/wallpaper.png &
    xrdb $HOME/.config/x11/xresources & xrdbpid=$!

    [ -n "$xrdbpid" ] && wait "$xrdbpid"

    ssh-agent dwm
  '';

  home.persistence."/nix/persist/home/binette" = {
    removePrefixDirectory = false;
    allowOther = true;
    directories = [
      ".cache/BraveSoftware"
      ".cache/Jellyfin Media Player"
      ".cache/librewolf"
      ".cache/qutebrowser"
      
      ".config/BraveSoftware"
      ".config/jellyfin.org"
      ".config/shell"
      ".config/tremc"
      ".config/discordcanary"
      ".config/powercord"
      ".config/tidal-hifi"
      
      ".local/bin"
      ".local/share/applications"
      ".local/share/cargo"
      ".local/share/gnupg"
      ".local/share/jellyfinmediaplayer"
      ".local/share/Jellyfin Media Player"
      ".local/share/password-store"
      ".local/share/xorg"
      ".local/share/zoxide"
      ".local/share/qutebrowser"

      ".git"
      ".librewolf"
      ".ssh"
      ".steam"
      ".gnupg"
      ".zplug"

      "documents"
      "pictures"
      "videos"
      "downloads"
    ];

    files = [
      ".config/.nvidia-settings-rc"
      ".config/pulse/daemon.conf"
      ".config/greenclip.toml"

      ".local/share/history"

      ".cache/greenclip.history"
    ];
  };

}
