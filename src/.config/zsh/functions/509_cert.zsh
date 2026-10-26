registr add cert_expiration_date "Check SSL certificate expiration for a server" "cert_expiration_date -s example.com"
function cert_expiration_date() {
    local server=""
    while getopts "s:" opt; do
        case $opt in s) server="$OPTARG" ;; esac
    done
    OPTIND=1

    if [[ -n "$server" ]]; then
        echo | openssl s_client -servername "$server" -connect "$server:443" 2>/dev/null \
            | openssl x509 -noout -dates
    else
        echo "Server URL is required. Usage: cert_expiration_date -s <server>"
    fi
}
