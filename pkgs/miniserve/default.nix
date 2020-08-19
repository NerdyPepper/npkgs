{ pkgs, stdenv, makeRustPlatform , fetchFromGitHub , pkg-config , zlib , openssl }:

let 
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  rustNightly = nixpkgs.latest.rustChannels.nightly.rust;
  rustPlatform = makeRustPlatform {
    cargo = rustNightly;
    rustc = rustNightly;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "miniserve";
    version = "0.8.0";

    src = fetchFromGitHub (builtins.fromJSON (builtins.readFile ./source.json));

    cargoSha256 = "180dvfikb7mnkah147gjcv19ayk1g5qp3qb4llw769havwkvrkx2";

    RUSTC_BOOTSTRAP = 1;

    nativeBuildInputs = [ pkg-config zlib ];
    buildInputs =  [ openssl ];

    meta = with stdenv.lib; {
      description = "For when you really just want to serve some files over HTTP right now!";
      homepage = "https://github.com/svenstaro/miniserve";
      license = licenses.mit;
    };
  }


