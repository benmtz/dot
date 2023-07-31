function fish_greeting
  set file $(random choice ~/.config/fish/greeters/*)
  cat $file | awk "{print substr(\$0,0,$(tput cols)) }" | lolcat
end
