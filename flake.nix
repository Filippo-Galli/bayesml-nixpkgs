{
  description = ''
    Nix packages for Bayesian statistics, simulation-based inference,
    and scientific machine learning
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

      pythonPackageNames = [
        "umnn"
        "bayesflow"
        "nflows"
        "sbi"
        "torchtestcase"
        "zuko"
      ];
    in
    {
      overlays.default = import ./overlay.nix;

      packages = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        nixpkgs.lib.genAttrs pythonPackageNames (name: pkgs.python3Packages.${name})
        // {
          mcclustext = pkgs.rPackages.mcclustext;
        }
      );

      checks = forAllSystems (system: self.packages.${system});

      devShells = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;

          mkPythonShell =
            names:
            pkgs.mkShell {
              packages = [
                (pkgs.python3.withPackages (ps: map (name: ps.${name}) names))
              ];
            };
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.git
              pkgs.nixfmt-tree
            ];
          };

        }
        // nixpkgs.lib.genAttrs pythonPackageNames (name: mkPythonShell [ name ])
        // {

          mcclustext = pkgs.mkShell {
            packages = [
              (pkgs.rWrapper.override {
                packages = [ pkgs.rPackages.mcclustext ];
              })
            ];
          };
        }
      );

      formatter = forAllSystems (system: (mkPkgs system).nixfmt-tree);
    };
}
