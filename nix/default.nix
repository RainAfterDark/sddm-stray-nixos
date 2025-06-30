{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  kdePackages,
}:

stdenvNoCC.mkDerivation {
  pname = "sddm-stray-nixos";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "RainAfterDark";
    repo = "sddm-stray-nixos";
    rev = "bd10417e62105cea7735f3908aeac1f72ff0607b";
    hash = "sha256-Bp/WswEMTC6H8eJgrxZnc5Z0F75b9f746v3bqw132u4=";
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = [
    kdePackages.qtsvg
    kdePackages.qtmultimedia
  ];

  buildPhase = ''
    runHook preBuild
    echo "No build step needed."
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    themeDir="$out/share/sddm/themes/sddm-stray-nixos"
    install -dm755 "$themeDir"

    cp -r "$src/theme/"* "$themeDir"

    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
    echo ${kdePackages.qtmultimedia} >> $out/nix-support/propagated-user-env-packages
  '';

  meta = with lib; {
    description = "NixOS modded Stray SDDM theme from Bqrry4/sddm-stray";
    homepage = "https://github.com/RainAfterDark/sddm-stray-nixos";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
