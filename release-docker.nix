{ system ? builtins.currentSystem }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  release = import ./release.nix { inherit sources pkgs; };

  name = "mschuwalow/helloworld";
  tag = "latest";

in pkgs.dockerTools.buildLayeredImage {
  inherit name tag;
  contents = [ release ];

  config = {
    Cmd = [ "/bin/helloworld" ];
    Env = [ "ROCKET_PORT=5000" ];
    WorkingDir = "/";
  };
}
