{
  lib,
  runCommand,
  stdenv,
  swift,
}:

# Make sure Swift targets the deployment target by default, not the macOS version of the build machine.
runCommand "swift-test-deployment-target"
  {
    nativeBuildInputs = [ swift ];
    meta.platforms = lib.platforms.darwin;
  }
  ''
    MACOSX_DEPLOYMENT_TARGET=15.4 swiftc -print-target-info | grep -F '"triple": "${stdenv.hostPlatform.swift.arch}-apple-macosx15.4"'
    env -u MACOSX_DEPLOYMENT_TARGET swiftc -print-target-info | grep -F '"triple": "${stdenv.hostPlatform.swift.triple}"'
    touch "$out"
  ''
