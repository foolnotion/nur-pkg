# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  asmjit = pkgs.callPackage ./pkgs/asmjit { };

  autodiff = pkgs.callPackage ./pkgs/autodiff { };

  cmake-init = pkgs.python39Packages.callPackage ./pkgs/cmake-init { };

  cpp-sort = pkgs.callPackage ./pkgs/cpp-sort { };

  eli5 = pkgs.python39Packages.callPackage ./pkgs/eli5 { };

  eovim = pkgs.callPackage ./pkgs/eovim { };

  fast_float = pkgs.callPackage ./pkgs/fast_float { };

  keyd = pkgs.callPackage ./pkgs/keyd { };

  librewolf = pkgs.callPackage ./pkgs/librewolf { };

  linasm = pkgs.callPackage ./pkgs/linasm { };

  mathpresso = pkgs.callPackage ./pkgs/mathpresso { };

  pareto = pkgs.python39Packages.callPackage ./pkgs/pareto { };

  pmlb = pkgs.python39Packages.callPackage ./pkgs/pmlb { };

  pratt-parser = pkgs.callPackage ./pkgs/pratt-parser { };

  robin-hood-hashing = pkgs.callPackage ./pkgs/robin-hood-hashing { };

  taskflow = pkgs.callPackage ./pkgs/taskflow { };

  vectorclass = pkgs.callPackage ./pkgs/vectorclass { };

  vstat = pkgs.callPackage ./pkgs/vstat { };
}
