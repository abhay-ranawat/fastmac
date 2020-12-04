code-server: v3.7.4
 VS Code: v1.51.1
Commit: 11f53784c58f68e7f4c5b3b8dae9407caa41725b
Date: 2020-12-02T00:08:06Z
Browser: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36/8mqQhSuL-09install_scripts(){
    #For Code-Server
    curl -fsSL https://code-server.dev/install.sh | sh
    #For Fly.io
    curl -L https://fly.io/install.sh | sh
    #For Starship
    wget https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz && tar -zxvf starship*.tar.gz && sudo cp starship /usr/bin/ && rm starship-x86_64-unknown-linux-gnu.tar.gz starship
    #For FFSend
    wget https://github.com/timvisee/ffsend/releases/download/v0.2.68/ffsend-v0.2.68-linux-x64-static && mv ./ffsend-* ./ffsend && chmod a+x ./ffsend && sudo mv ./ffsend /usr/bin/ 
}
install_apt(){
    sudo apt-get update && sudo apt-get install -y httpie 
}
install_npm(){
    sudo npm install -g spt-cli flipacoin localtunnel
}
bashrc(){
    #Modifying Bashrc
    #Adding Starship to Bashrc
    echo 'eval "$(starship init bash)"' >> /home/runner/.bashrc
    #Adding Fly to Bashrc
    echo 'export FLYCTL_INSTALL="/root/.fly"' >> /root/runner/.bashrc
    echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> /root/runner/.bashrc
}
install_extensions(){
    code-server --force --install-extension eamodio.gitlens
    code-server --force --install-extension github.github-vscode-theme
    code-server --force --install-extension github.vscode-pull-request-github
    code-server --force --install-extension compulim.vscode-ipaddress
    code-server --force --install-extension esbenp.prettier-vscode
}
restore_state(){
    wget https://github.com/ClassOfCode/test/raw/master/code-server-colab.zip && unzip code-server-colab.zip && mv code-server /home/.local/share/ && rm code-server-colab.zip
    mkdir /home/coder/
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
bashrc
install_extensions
restore_state
code &
tunnel &
