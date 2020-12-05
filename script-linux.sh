#!/bin/bash
install_scripts(){
    #For Code-Server
    curl -fsSL https://code-server.dev/install.sh | bash
    #For Fly.io
    curl -L https://fly.io/install.sh | sudo bash
}
install_snapd(){
    sudo snap install starship
}
install_apt(){
    sudo apt-get update && sudo apt-get install -y httpie 
}
install_npm(){
    sudo npm install -g spt-cli flipacoin localtunnel
}
install_brew(){
     brew install mongosh ffsend youtube-dl
}
bashrc(){
    #Modifying Bashrc
    #Adding Starship to Bashrc
    sudo echo 'eval "$(starship init bash)"' >> ~/.bashrc
    #Adding Fly to Bashrc
    sudo echo 'export FLYCTL_INSTALL="/home/runner/.fly"' >> ~/.bashrc
    sudo echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> ~/.bashrc
}
install_extensions(){
    code-server --force --install-extension eamodio.gitlens
    code-server --force --install-extension github.github-vscode-theme
    code-server --force --install-extension github.vscode-pull-request-github
    code-server --force --install-extension compulim.vscode-ipaddress
    code-server --force --install-extension esbenp.prettier-vscode
}
restore_state(){
    wget https://github.com/ClassOfCode/test/raw/master/code-server-colab.zip && unzip code-server-colab.zip && mkdir /home/runner/.local/ && mkdir /home/runner/.local/share/ && sudo mv code-server /home/runner/.local/share/ && rm code-server-colab.zip
    sudo mkdir /home/coder/
}
code(){
    code-server --auth none --disable-telemetry /home/coder/
}
tunnel(){
    lt --port 8080 -s gcode
}

bashrc
bash
install_scripts
install_apt
install_npm
install_snapd
restore_state
install_extensions
code &
tunnel &
