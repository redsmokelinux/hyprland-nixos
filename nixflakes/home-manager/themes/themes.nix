
{ config, pkgs, ... }:

{


    # gtk.enable = true;

    # gtk.cursorTheme.package = pkgs.graphite-cursors;
    # gtk.cursorTheme.name = "Bibata-Modern-Ice";

    # gtk.theme.package = pkgs.andromeda-gtk-theme;
    # gtk.theme.name = "Andromeda";

    # gtk.iconTheme.package = pkgs.tela-icon-theme;
    # gtk.iconTheme.name = "Tela-yellow-dark";


      gtk = {
    enable = true;

    theme = {
      package = pkgs.andromeda-gtk-theme;
      name = "Andromeda";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-yellow-dark";
    };

    #font = {
    #  name = "JetBrains Mono";
    #  size = 11;
    # };
  };



# Themes

    qt.enable = true;
    qt.platformTheme.name = "gtk";
    qt.style.name = "Andromeda";
    qt.style.package = pkgs.andromeda-gtk-theme;

}