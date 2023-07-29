{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, openssl
}:

rustPlatform.buildRustPackage rec {
  pname = "espup";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "esp-rs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-gzM+RT4Rt+LaYk7CwYUTIMci8DDI0y3+7y+N2yKRDOc=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  checkFlags = [
    # makes network calls
    "--skip=toolchain::rust::tests::test_xtensa_rust_parse_version"
    # fails
    "--skip=env::tests::test_get_export_file"
  ];

  OPENSSL_NO_VENDOR = "1";

  cargoHash = "sha256-GYhF6VDBAieZbu4x9EiQVVJkmx0aRYK0xwGGP0nuVGc=";

  meta = with lib; {
    description = "Tool for installing and maintaining Espressif Rust ecosystem.";
    homepage = "https://github.com/esp-rs/espup";
    license = with licenses; [ mit asl20 ];
    maintainers = [ maintainers.knightpp ];
  };
}
