curl -fsSL https://code-server.dev/install.sh | sh
sudo npm i -g spt-cli localtunnel
code(){
     code-server --auth none --disable-telemetry
}
tunnel(){
lt --port 8080
}
code &
tunnel &
