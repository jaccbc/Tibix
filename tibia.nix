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
      pkgs.libsm
      pkgs.libice
      pkgs.stdenv.cc.cc
      pkgs.libGL
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.libX11
      pkgs.libXext
      pkgs.libXrandr
      pkgs.libxcb
      pkgs.libxcb-cursor
      pkgs.libxcb-image
      pkgs.libxcb-keysyms
      pkgs.libxcb-render-util
      pkgs.libxcb-util
      pkgs.libxcb-wm
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
      pkgs.zstd
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
      pkgs.libwebp
      pkgs.udev
      pkgs.libgbm
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
      export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri
      export QSG_RENDER_LOOP=basic
      export QT_QPA_PLATFORM=xcb
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export QT_ENABLE_HIGHDPI_SCALING=0
    '';

    # start Tibia client
    runScript = ''
      ${builtins.toString ./.}/Tibia
    '';
  }
