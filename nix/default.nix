
{ lib
, stdenvNoCC
, fetchFromGitHub
, kdePackages
, formats
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-stray";
  version = "1.0";

  src = fetchFromGitHub { 
    owner = "Bqrry4";
    repo = "sddm-stray";
    rev = "0dfb0c59b16a985df2cc0b77a08fa9fb5c484c46";
    hash = "sha256-/vvD9ccFyPhoR0oUTHHR+kBh7BezbfmKKOupjEr6mGk=";
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

    themeDir="$out/share/sddm/themes/sddm-stray"
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
    description = "Stray SDDM theme from Bqrry4/sddm-stray";
    homepage = "https://github.com/Bqrry/sddm-stray";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
