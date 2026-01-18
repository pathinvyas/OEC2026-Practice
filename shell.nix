{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
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
        sha256 = "0ajsdd3m4qz8mpimfcrawx81cqj8s5ypnkrxpwy7icj9j8gcpksa";
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
  ];

  shellHook = ''
    export PATH=$ANDROID_HOME/platform-tools:$PATH
  '';
}
