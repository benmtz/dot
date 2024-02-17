if set -q USE_CUSTOM_GREETER;
  function fish_greeting
    set file $(random choice ~/.config/fish/greeters/*)
    if type -q lolcat
      cat $file | sed -r "s/(.{0,$(tput cols)}).*/\1/" | lolcat
    else
      cat $file | sed -r "s/(.{0,$(tput cols)}).*/\1/"
    end
  end
end

