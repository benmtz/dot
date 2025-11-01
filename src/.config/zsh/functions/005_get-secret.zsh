registr add get-secret "Retrieve a secret from macOS Keychain" "get-secret <account>"
function get-secret() {
  security find-generic-password -s bm -a "$1" -w
}
