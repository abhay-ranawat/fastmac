curl -fsSL https://code-server.dev/install.sh | sh && cargo install tunnelto && code-server --auth none >/dev/null && tunnelto --port 8080
