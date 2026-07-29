{ pkgs ? import <nixpkgs> {} }:

let
  tibiaLibs = pkgs.runCommand "tibia-local-libs" {} ''
    mkdir -p $out/lib
    cp -a ${./lib}/* $out/lib
  '';
in
  pkgs.buildFHSEnv {
    name = "Tibix";

    targetPkgs = pkgs: [
      # system dependencies
      pkgs.stdenv.cc.cc
      pkgs.libGL
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.libX11
      pkgs.libXext
      pkgs.libXrandr
      pkgs.libxcb
      pkgs.libXcomposite
      pkgs.libXdamage
      pkgs.libXfixes
      pkgs.libXtst
      pkgs.libxkbfile
      pkgs.xcbutilxrm
      pkgs.expat
      pkgs.wayland
      pkgs.freetype
      pkgs.zlib
      pkgs.brotli
      pkgs.fontconfig
      pkgs.libxkbcommon
      pkgs.dbus
      pkgs.openssl
      pkgs.nss_latest
      pkgs.nspr
      pkgs.libevent
      pkgs.libdrm
      pkgs.alsa-lib
      pkgs.libxml2
      pkgs.libxslt
      # tibia libraries
      tibiaLibs
    ];

    # mount paths required for AMD graphics acceleration
    extraMounts = [
      { source = "/dev/dri"; target = "/dev/dri"; isReadOnly = false; }
      { source = "/run/opengl-driver"; target = "/run/opengl-driver"; isReadOnly = true; }
    ];

    # local libraries
    profile = ''
      export LD_LIBRARY_PATH=${tibiaLibs}/lib:$LD_LIBRARY_PATH
    '';

    # start Tibia client
    runScript = ''
      ${builtins.toString ./.}/Tibia
    '';
  }
