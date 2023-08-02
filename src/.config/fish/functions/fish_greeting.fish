function fish_greeting
  set file $(random choice ~/.config/fish/greeters/*)
  cat $file | sed -r "s/(.{0,$(tput cols)}).*/\1/" | lolcat
end
