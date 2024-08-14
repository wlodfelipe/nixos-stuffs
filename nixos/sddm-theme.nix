{ pkgs }:

let
  imgLink = "https://raw.githubusercontent.com/wlodfelipe/nixos-stuffs/main/billyboyrain.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "0l6y59nm3di8vcrz7ln6ygfak0sf6sklzm639sxnxvbp5hjj5l8n";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}
