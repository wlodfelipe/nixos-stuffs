with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "dwm-env";
  buildInputs = [
    pkgs.xorg.libX11
    pkgs.xorg.libXft
    pkgs.xorg.libXinerama
    pkgs.xorg.libXrandr
    pkgs.xorg.libXrender
    pkgs.stdenv.cc
    pkgs.pkgconfig
    # Add other dependencies here
  ];
}

