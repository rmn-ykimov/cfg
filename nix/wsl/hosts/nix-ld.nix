{ pkgs, ... }:
{
  # Prebuilt Linux binaries: Hermes pm tools (Python, Node, Chrome for Testing,
  # cua-driver), gbrain release binary, Selenium Chrome.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      zstd
      openssl
      curl
      expat
      icu
      libffi
      util-linux
      systemd

      # Chrome / Electron / cua-driver
      glib
      nss
      nspr
      atk
      at-spi2-atk
      at-spi2-core
      dbus
      cups
      libdrm
      libgbm
      mesa
      libGL
      alsa-lib
      libxkbcommon
      cairo
      pango
      gtk3
      gdk-pixbuf
      freetype
      fontconfig
      libx11
      libxcb
      libxext
      libxcomposite
      libxdamage
      libxfixes
      libxrandr
      libxrender
      libxi
      libxtst
      libxcursor
      libxscrnsaver
      libxshmfence
    ];
  };
}
