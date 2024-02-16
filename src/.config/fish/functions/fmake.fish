function _find_nearest_makefile
  set current_directory $PWD
  while test "$current_directory" != "$HOME"; and test -n $nearest_makefile_toml;
    set candidate $current_directory/Makefile.toml
    if test -f $candidate
      echo "$candidate"
      return 0
    end
    set current_directory $(readlink -f "$current_directory/..")
  end
  return 1
end

function fmake
  
  argparse l/loop -- $argv

  set origin $PWD
  cd $(dirname $(_find_nearest_makefile))

  set result $(cargo make --list-category-steps "No Category" --hide-uninteresting  --disable-check-for-updates | grep -Eo '^([a-zA-Z].*) -' | sed 's/ -$//g' | fzf)
  echo $result

  if test -n $result
    cargo make $result
  end

  if set -ql _flag_loop
    echo ""
    read -P "Enter to continue..."
    fmake -l
  end

  cd $origin

end
