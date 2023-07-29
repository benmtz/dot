function fish_greeting
  cat ~/.config/greeter.txt | cut -c -$(tput cols) | lolcat
end
