# bayesml-nixpkgs

Nix packages and overlays for Bayesian statistics,
simulation-based inference, and scientific machine learning.

This repository provides reusable package definitions for libraries
that are missing from Nixpkgs or need locally maintained variants.

It is a standalone package collection, not a fork of Nixpkgs.

## Package definitions

| Package | Ecosystem | Build |
|---|---|---|
| [UMNN](https://github.com/AWehenkel/UMNN) | Python | `nix build .#umnn` |
| [BayesFlow](https://github.com/bayesflow-org/bayesflow) | Python | `nix build .#bayesflow` |
| [nflows](https://github.com/bayesiains/nflows) | Python | `nix build .#nflows` |
| [sbi](https://github.com/sbi-dev/sbi) | Python | `nix build .#sbi` |
| [torchtestcase](https://github.com/phohenecker/torch-test-case) | Python | `nix build .#torchtestcase` |
| [zuko](https://github.com/probabilists/zuko) | Python | `nix build .#zuko` |
| [mcclust.ext](https://github.com/sarawade/mcclust.ext) | R | `nix build .#mcclustext` |

Build and platform support are work in progress.

## Build a package

From a local checkout:

```sh
nix build .#sbi
```

From GitHub:

```sh
nix build github:Filippo-Galli/bayesml-nixpkgs#sbi
```

Building a Python library produces its package output.
To import it interactively, use a development shell.

## Development shells

Enter a shell containing one Python library:

```sh
nix develop .#sbi
python -c 'import sbi'
```

Enter the mcclust.ext environment:

```sh
nix develop .#mcclustext
```

The default shell provides repository maintenance tools:

```sh
nix develop
```

## Use the overlay in another flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    bayesml-nixpkgs.url =
      "github:Filippo-Galli/bayesml-nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      bayesml-nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          bayesml-nixpkgs.overlays.default
        ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps: [
            ps.sbi
            ps.zuko
          ]))
        ];
      };
    };
}
```

The consuming project chooses its Nixpkgs revision.
Package compatibility with arbitrary Nixpkgs revisions is not guaranteed.

## Repository layout

- `pkgs/`: package recipes.
- `overlay.nix`: Python and R package-set extensions.
- `flake.nix`: build outputs, checks, development shells, and formatter.
- `flake.lock`: pinned flake inputs.

## Adding a package

1. Add a package function at `pkgs/<name>/default.nix`.
2. Register it in the appropriate package set in `overlay.nix`.
3. Expose it through `packages` in `flake.nix`.
4. Update this README.
5. Build the package and test its imports.

Use dependencies passed as function arguments rather than importing
Nixpkgs inside individual recipes.

Python recipes should use `buildPythonPackage`.
R recipes should use `buildRPackage`.

## Maintenance

Format the repository:

```sh
nix fmt
```

Inspect the flake:

```sh
nix flake show
```

Evaluate checks without building them:

```sh
nix flake check --no-build
```

Build checks for the current system:

```sh
nix flake check
```

Update the pinned inputs:

```sh
nix flake update
```

Review and test input updates before committing `flake.lock`.

## Upstreaming

Generally useful packages should be contributed to Nixpkgs when practical.

This collection can also host pending additions, experimental packaging,
and variants needed by research projects.
