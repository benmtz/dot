function nx
  NX_DAEMON=false NX_TUI=false npx nx $argv
end

function dnx
  npx nx daemon --start
  NX_DAEMON=true NX_TUI=false npx nx $argv
end

function nx-kill-executors
  pkill -f "plugin-worker"
  ps aux | grep nrwl | tr -s " " | cut -d " " -f 2 | xargs -I{} kill -9 {}
end
