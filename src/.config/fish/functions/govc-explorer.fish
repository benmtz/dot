
function govc-explorer

  argparse l/loop -- $argv

  set vm $(govc ls "/*/vm/*" | fzf)
  if test -n $result
    govc vm.info $vm
  end

end
