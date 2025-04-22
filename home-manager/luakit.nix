{ pkgs, ... }: pkgs.stdenv.mkDerivation {
  name = "luakit";
  system = builtins.currentSystem;
  builder = "${pkgs.make}/bin/make";
  src = pkgs.fetchFromGitHub {
    owner = "luakit";
    repo = "luakit";
    hash = "";
    rev = "636637c"; 
  };
}
