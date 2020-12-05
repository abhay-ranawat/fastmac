install_scripts(){
    #For Code-Server
    curl -fsSL https://code-server.dev/install.sh | sh
    #For Fly.io
    curl -L https://fly.io/install.sh | sh
}
install_apt(){
    sudo apt-get update && sudo apt-get install -y httpie 
}
install_npm(){
    sudo npm install -g spt-cli flipacoin localtunnel
}
install_brew(){
     brew install mongosh starship ffsend youtube-dl
}
bashrc(){
    #Modifying Bashrc
    #Adding Starship to Bashrc
    sudo echo 'eval "$(starship init bash)"' >> /home/runner/.bashrc
    #Adding Fly to Bashrc
    sudo echo 'export FLYCTL_INSTALL="/root/.fly"' >> /root/runner/.bashrc
    sudo echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> /root/runner/.bashrc
}
install_extensions(){
    code-server --force --install-extension eamodio.gitlens
    code-server --force --install-extension github.github-vscode-theme
    code-server --force --install-extension github.vscode-pull-request-github
    code-server --force --install-extension compulim.vscode-ipaddress
    code-server --force --install-extension esbenp.prettier-vscode
}
restore_state(){
    wget https://github.com/ClassOfCode/test/raw/master/code-server-colab.zip && unzip code-server-colab.zip && sudo mv code-server /home/.local/share/ && rm code-server-colab.zip
    sudo mkdir /home/coder/
}
code(){
    code-server --auth none --disable-telemetry /home/coder/
}
tunnel(){
    lt --port 8080 -s gcode
}

install_scripts
install_apt
install_npm
install_extensions
restore_state
code &
tunnel &
