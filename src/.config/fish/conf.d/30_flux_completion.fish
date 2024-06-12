set -l flux_completion_file ~/.config/fish/completions/flux.fish

if type -q flux
  if not test -e $flux_completion_file
      flux completion fish > $flux_completion_file
      echo 'Flux completion loaded successfully!'
  end
end
