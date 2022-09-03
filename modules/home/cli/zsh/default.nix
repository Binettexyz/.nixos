{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.cli.zsh;
in
{
  options.modules.cli.zsh = {
    enable = mkOption {
      description = "Enable Zsh package";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf (cfg.enable) {
    programs.zsh = {
      enable = true;
        # zsh directory
      dotDir = ".config/zsh";
  
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      autocd = true;
  
        # .zshrc
      initExtra = ''
        autoload -U colors && colors
        setopt promptsubst
        PS1="%B%{$fg[magenta]%}[%{$fg[cyan]%}%n%{$fg[blue]%} %~%{$fg[magenta]%}]%{$reset_color%}$%b "
  
        setopt interactive_comments
  
        source "$HOME/.config/shell/aliasrc"
  
          # Use lf to switch directories and bind it to ctrl-o
        lfcd () {
          tmp="$(mktemp)"
          lf -last-dir-path="$tmp" "$@"
          if [ -f "$tmp" ]; then
             dir="$(cat "$tmp")"
             rm -f "$tmp" >/dev/null
             [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
          fi
        }
  
        bindkey '^ ' autosuggest-accept
        bindkey '^h' autosuggest-clear
        '';
  
        # aliases directories
      dirHashes = {
        docs = "$HOME/documents";
        vids = "$HOME/videos";
        pics = "$HOME/pictures";
        dl = "$HOME/downloads";
        git = "$HOME/.git";
        dots = "/nix/persist/home/binette/.dotfiles";
        nix = "/etc/nixos";
      };
  
        # history settings
      history = {
        save = 1000;
        size = 1000;
        path = "/nix/persist/home/binette/.cache/zsh/history";
        expireDuplicatesFirst = true;
      };
  
        # aliases
      shellAliases = {
          # Nixos related aliases.
        nixsh = "nix-shell -p";
        nixbuild = "pushd /etc/nixos; doas nixos-rebuild switch --flake .#; popd; notify-send '❄️ NixOS' 'Rebuild complete!'";
        nixup = "pushd /etc/nixos; doas nix flake update; popd; notify-send '❄️ NixOS' 'Update complete!'";
      };
  
      envExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  	. "$HOME/.config/shell/profile" && exec startx $HOME/.config/x11/xinitrc &> /dev/null;
        else
  	. "$HOME/.config/shell/profile"
        fi
        '';
  
      plugins = [
          # to find sha256, keep it empty and the build error will find it for you
        {
          name = "zsh-vi-mode";
          src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "debe9c8ad191b68b143230eb7bee437caba9c74f";
            sha256 = "sha256-rgC1lKyZluYHi4Fk8zUSgMM/UqrJ6QcwYGvaDyuWAxo=";
          };
  
        }
      ];
    };
  };

}