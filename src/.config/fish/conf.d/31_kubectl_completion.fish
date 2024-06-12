set -l kubectl_completion_file ~/.config/fish/completions/kubectl.fish

if type -q kubectl
  if not test -e $kubectl_completion_file
      kubectl completion fish > $kubectl_completion_file
      echo 'Kubectl completion loaded successfully!'
  end
end
