{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  },
}:

let
  # Get commit from: https://status.nixos.org/
  commit = "45a153068326";

  unstable =
    import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/${commit}.tar.gz";
        sha256 = "1x2znfvddc1wfk1ylpzi83is2nhpmjm0azixs3jqgwdz1a50lk6q";
      })

      {
        config = {
          allowUnfree = true;
        };
      };

in
pkgs.mkShell {
  buildInputs = [
    pkgs.git
    unstable.flutter

    pkgs.google-chrome
  ];

  shellHook = ''
    export CHROME_EXECUTABLE="${pkgs.google-chrome}/bin/google-chrome-stable"
  '';
}
