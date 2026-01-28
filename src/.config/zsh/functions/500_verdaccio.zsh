registr add verdaccio-setup "Set up a local Verdaccio npm registry with a test user" "verdaccio-setup"
function verdaccio-setup() {
    # Create simple htpasswd file with a test user (password: test)
    touch ~/.verdaccio/storage/htpasswd
    htpasswd -nb test test > ~/.verdaccio/storage/htpasswd

    docker stop verdaccio || true
    docker rm verdaccio || true

    V_PATH=~/.verdaccio; docker run -d --name verdaccio \
      -p 4873:4873 \
      -v $V_PATH/conf:/verdaccio/conf \
      -v $V_PATH/storage:/verdaccio/storage \
      -v $V_PATH/plugins:/verdaccio/plugins \
      verdaccio/verdaccio
    
    echo "Waiting for Verdaccio to start..."
    npx --yes wait-on http://localhost:4873
    
    echo "Verdaccio is running at http://localhost:4873"
    echo "Setting registry and logging in..."
    
    # Set registry
    npm config set registry http://localhost:4873/

    # Try to login with npm login using expect
    expect << 'EOF'
spawn npm login --registry http://localhost:4873
expect "Username:"
send "test\r"
expect "Password:"
send "test\r"
expect {
    "Email:" {
        send "test@example.com\r"
        exp_continue
    }
    "Logged in" {
        puts "Login successful!"
    }
}
EOF
    
    echo "Testing authentication..."
    npm whoami --registry http://localhost:4873

    echo "✅ Verdaccio setup complete! Ready to publish packages!"
}
