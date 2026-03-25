#{ lib, stdenv, fetchFromGitHub, nodejs, npm, git, python3, lightdm, gobject-introspection, cairo, xorg }:
{ lib, stdenv, nodejs, npm, python3, src }:

stdenv.mkDerivation rec {
  pname = "nody-greeter";
  version = "1.6.2";

  src = ./.;
  #nativeBuildInputs = [ nodejs npm git python3 ];
  #buildInputs = [ lightdm gobject-introspection cairo xsetroot ];
  nativeBuildInputs = [ nodejs npm python3 ];


  #patches = [ ./install.patch ];

  buildPhase = ''
    npm install
    npm run rebuild
    npm run build
  '';

  installPhase = ''
    mkdir -p "$out/opt/nody-greeter"
    cp -r . "$out/opt/nody-greeter"

    mkdir -p "$out/usr/bin"
    ln -s "$out/opt/nody-greeter/nody-greeter" "$out/usr/bin/nody-greeter"
  '';

  meta = with lib; {
    description = "LightDM greeter that allows to create wonderful themes with web technologies";
    homepage = "https://github.com/JezerM/nody-greeter";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
