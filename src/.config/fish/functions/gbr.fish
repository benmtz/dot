function gbr
  fd -t d -H --format '{//}' --glob ".git" | xargs -I{} bash -c 'echo -n "{} - "; git -C {} rev-parse --abbrev-ref HEAD'
end
