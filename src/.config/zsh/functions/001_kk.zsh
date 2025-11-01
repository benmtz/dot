registr add kk "Send SIGKILL to all processes matching the name" "kk vitest"
function kk() {
  echo "Cleaning $1..."
  ps aux | grep $1 | tr -s " " | cut -d " " -f 2 | xargs -I{} kill -9 {}
}
