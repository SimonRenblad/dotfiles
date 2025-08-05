{
  pkgs,
  naersk,
}:
let
  naersk' = pkgs.callPackage naersk { };
in
naersk'.buildPackage {
  src = pkgs.fetchFromGitHub {
    owner = "wtnqk";
    repo = "ftdv";
    rev = "v0.1.2";
    hash = "sha256-J1lWrfZeH/V1hckLGWDoeU6aKFoLimddzaTKMQ8sDs8=";
  };
}
