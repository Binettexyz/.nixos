{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.services.picom;
in
{
  options.modules.services.picom = {
    enable = mkOption {
      description = "Enable picom service";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) {
    services.picom = {
        # Enabled client-side shadows on windows. 
      enable = true;
      backend = "glx";

      /* Opacity */
      activeOpacity = 1.0; # (0.0 - 1.0 )
      inactiveOpacity = 0.8; # (0.0 - 1.0 )
      opacityRules = [
        "100:class_g = 'Navigator'"
        "100:class_g = 'Dunst'"
      ];

      /* Fading */
      fade = true;
        # The time between steps in fade step, in milliseconds.
      fadeDelta = 5; # (> 0, defaults to 10)
        # Opacity change between steps while fading in. (in) (out)
      fadeSteps = [ (0.03) (0.03) ]; # (0.01 - 1.0, defaults to [ (0.028) (0.03) ])
      fadeExclude = [
        "class_g = 'st'"
      ];

      /* Shadow */
      shadow = false;
        # The opacity of shadows.
      shadowOpacity = 0.75; # (0.0 - 1.0, defaults to 0.75)
        # Offset for shadows, in pixels. (left) (right)
      shadowOffsets = [ (-7) (-7) ]; # (defaults to -15)
        # Specify a list of conditions of windows that should have no shadow.
      shadowExclude = [
        "class_g = 'slop'"   # maim
      ];

        # Reduce screen tearing
      vSync = true;

      /* Extra settings */
      settings = {
        /* Shadow */
          # The blur radius for shadows, in pixels.
        shadow-radius = 7; # (defaults to 12)

        /* Fading */
          # Specify a list of conditions of windows that should not be faded.
        fade-exclude = [
          "class_g = 'st'"
        ];

        /* Blur */
        blur = {
          method = "dual_kawase";
          strength = 7;
            # Use fixed blur strength rather than adjusting according to window opacity
          background-fixed = true;
        };

        /* Wintype */
        wintypes = {
          normal = { fade = false; shadow = false; };
          notification = { fade = true; shadow = true; };
          popup_menu = { opacity = 0.8; };
          dropdown_menu = { opacity = 0.8; };
        };
      };
    };
  };
}