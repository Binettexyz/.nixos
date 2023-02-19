{ pkgs, config, lib, ... }:
with lib;

{
    services.picom = {
        # Enabled client-side shadows on windows. 
      enable = true;
      backend = "glx";

      /* Opacity */
      activeOpacity = 0.7; # (0.0 - 1.0 )
      inactiveOpacity = 0.6; # (0.0 - 1.0 )
      opacityRules = [
        "100:class_g = 'Dunst'"
        "100:class_g = 'librewolf'"
        "100:class_g = 'Brave-browser'"
        "100:class_g = 'mpv'"
        "100:class_g = 'Minecraft*'"
        "100:class_g = 'Jellyfin Media Player'"
        "100:class_g = 'discord'"
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
      ];

        # Reduce screen tearing
      vSync = true;

      /* Extra settings */
      settings = {
        /* Shadow */
          # The blur radius for shadows, in pixels.
        shadow-radius = 7; # (defaults to 12)

        /* Focus */

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
          blur-background-exclude = [
            "class_g = 'librewolf'"
            "class_g = 'mpv'"
            "class_g = 'Brave-browser'"
            "class_g = 'Minecraft*'"
            "class_g = 'Jellyfin Media Player'"
            "class_g = 'discord'"
          ];
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

}