function gtask
  
  argparse l/loop -- $argv

  set result $(task --global --list-all | sed -e '1d; s/\* \(.*\):\s*\(.*\)\s*(aliases.*/\1\t\2/' -e 's/\* \(.*\):\s*\(.*\)/\1\t\2/' | awk '{$1= $1};1' | fzf)
  if test -n $result
    task --global $result
  end

  if set -ql _flag_loop
    echo ""
    read -P "Enter to continue..."
    gtask -l
  end

end
