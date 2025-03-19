{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  buildGoModule,
  buf,
  cacert,
  grpc-gateway,
  protoc-gen-go,
  protoc-gen-go-grpc,
  protoc-gen-validate,
  pnpm,
  nodejs,
  makeWrapper,
  pkgs,
}: let
  version = "0.24.0";
  src = fetchFromGitHub {
    owner = "usememos";
    repo = "memos";
    rev = "v${version}";
    hash = "sha256-pEFdVxKhTNzP8gOlViD2vAmpMgHS0v149tnqlgwSnnc=";
  };
  goModulesHash = "sha256-E8vGpoVICfVsjaSK4k28WYYfWXaw8mKZXMX1QcvAnTI=";

  buildMemosProtocGen = name:
    buildGoModule {
      pname = "protoc-gen-${name}";
      inherit version;

      src = src;

      proxyVendor = true;
      vendorHash = goModulesHash;

      buildPhase = ''
        go install internal/protoc/protoc-gen-${name}/main.go
      '';

      postInstall = ''
        mv $out/bin/main $out/bin/protoc-gen-${name}
      '';
    };

  generateProtobufCode = {
    pname,
    nativeBuildInputs ? [],
    bufArgs ? "",
    workDir ? ".",
    outputPath,
    hash,
  }:
    stdenvNoCC.mkDerivation {
      name = "${pname}-buf-generated";
      inherit src;

      nativeBuildInputs =
        nativeBuildInputs
        ++ [
          buf
          cacert
        ];

      buildPhase = ''
        cd ${workDir}/proto
        HOME=$TMPDIR buf generate ${bufArgs}
      '';

      installPhase = ''
        cp -r ${outputPath} $out
      '';

      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = hash;
    };

  protobufGenerated = generateProtobufCode {
    pname = "memos";
    nativeBuildInputs = [
      grpc-gateway
      protoc-gen-go
      protoc-gen-go-grpc
      protoc-gen-validate
    ];
    outputPath = "gen";
    hash = "sha256-LLmf9w4vlcakm/dBm6Zfc94HTwR/Hkc02tFXUXmXQ0g=";
  };

  protobufTypes = generateProtobufCode {
    pname = "memos";
    nativeBuildInputs = [
      grpc-gateway
      protoc-gen-go
      protoc-gen-go-grpc
      protoc-gen-validate
    ];
    outputPath = "../web/src/types/proto";
    hash = "sha256-CCq1vw0OYnIYZZJmCYNwe3tEYkdV0BzHSwz3PQGHHSM=";
  };

  frontend = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "memos-web";
    inherit version src;
    pnpmDeps = pnpm.fetchDeps {
      inherit (finalAttrs) pname version src;
      sourceRoot = "${finalAttrs.src.name}/web";
      hash = "sha256-z6Q5t8M7gjDRs8K5XsvnOpcp0PYLXte8OJfEDasgBHU=";
    };
    pnpmRoot = "web";
    nativeBuildInputs = with pkgs; [nodejs pnpm.configHook];
    preBuild = ''
      cp -r ${protobufTypes} web/src/types/proto
    '';
    buildPhase = ''
      runHook preBuild
      pnpm -C web build
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      cp -r web/dist $out
      runHook postInstall
    '';
  });
in
  buildGoModule rec {
    pname = "memos";
    inherit version src;

    doCheck = false;
    proxyVendor = true;
    vendorHash = goModulesHash;

    prePatch = ''
      rm -rf server/router/frontend/dist
      cp -r ${frontend} server/router/frontend/dist
    '';

    preBuild = ''
      cp -r ${protobufGenerated} gen
    '';
  }
