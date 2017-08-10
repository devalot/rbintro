{ nixpkgs ? import <nixpkgs> { }
}:

let pkgs = nixpkgs.pkgs;
    stdenv = pkgs.stdenv;

    ruby = pkgs.ruby_2_4.override {
      docSupport = true;
    };

in stdenv.mkDerivation rec {
  name = "rbintro";

  buildInputs = with pkgs;
    [ ruby
      gcc
    ];

  shellHook = ''
    export GEM_HOME=$(pwd)/gems
    export PATH=$GEM_HOME/bin:$PATH
  '';
}
