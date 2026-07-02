{
  mkTarget,
  lib,
  options,
  pkgs,
  ...
}:
mkTarget {
  config = lib.optionals (options.programs ? dank-material-shell) [
    (
      { fonts }:
      {
        programs.dank-material-shell.settings = {
          fontFamily = fonts.sansSerif.name;
          monoFontFamily = fonts.monospace.name;
        };
      }
    )
    (
      { opacity }:
      {
        programs.dank-material-shell.settings = {
          popupTransparency = opacity.popups;
          dockTransparency = opacity.desktop;
        };
      }
    )
    (
      { image }:
      {
        programs.dank-material-shell.session = {
          wallpaperPath = image;
          wallpaperPathLight = image;
          wallpaperPathDark = image;
        };
      }
    )
    (
      { colors }:
      {
        programs.dank-material-shell.settings = {
          currentThemeName = "custom";
          customThemeFile =
            let
              theme = with colors.withHashtag; {
                name = "Stylix";
                primary = base0D;
                primaryText = base00;
                primaryContainer = base0C;
                secondary = base0E;
                surface = base00;
                surfaceText = base05;
                surfaceVariant = base00;
                surfaceVariantText = base04;
                surfaceTint = base01;
                background = base00;
                backgroundText = base05;
                outline = base03;
                surfaceContainer = base00;
                surfaceContainerHigh = base01;
                surfaceContainerHighest = base01;
                error = base08;
                warning = base0A;
                info = base0C;
              };
            in
            pkgs.writeText "dankMaterialShell-stylix-color-theme.json" (
              builtins.toJSON {
                dark = theme;
                light = theme;
              }
            );
        };
      }
    )
  ];
}
