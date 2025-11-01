registr add nx "Run nx commands with NX_DEAMON and NX_TUI disabled" "nx build my-app"
function nx() {
  NX_DEAMON=false NX_TUI=false npx nx $@
}



