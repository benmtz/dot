
function cert_expiration_date

  argparse 's/server=' -- $argv

  echo "$_flag_s"
  if set -q _flag_s
    echo | openssl s_client -servername $_flag_s -connect $_flag_s:443 2>/dev/null | openssl x509 -noout -dates
  else
    echo "Server URL is required."
  end

end
