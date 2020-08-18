{ stdenv , fetchFromGitHub , rustPlatform , installShellFiles }:

rustPlatform.buildRustPackage rec {
    pname = "delta";
    version = "0.4.1";

    src = fetchFromGitHub {
        owner = "dandavison";
        repo = pname;
        rev = version;
        sha256 = "15vpmalv2195aff3xd85nr99xn2dbc0k1lmlf7xp293s79kibrz7";
    };

    cargoSha256 = "0b8hvy0brj7d1shcbrzchdcf688j1b2wr0cw5bkb2fndjxmr49g7";
    nativeBuildInputs = [ installShellFiles ];
    postInstall = ''
        installShellCompletion --bash --name delta.bash etc/completion/completion.bash
    '';
}

