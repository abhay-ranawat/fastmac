install_scripts(){
    #For Code-Server
    curl -fsSL https://code-server.dev/install.sh | bash
    #For Fly.io
    curl -L https://fly.io/install.sh | sudo bash
}
install_snapd(){
    sudo snap install starship youtube-dl ffsend
    sudo snap install --classic heroku
}
install_apt(){
    sudo apt-get update
    sudo apt-get install -y httpie 
}
install_npm(){
    sudo npm install -g spt-cli flipacoin localtunnel
}
install_prog(){
    #For MongoSH
    wget https://github.com/mongodb-js/mongosh/releases/download/v0.6.1/mongosh_0.6.1_amd64.deb
    sudo dpkg --install mongosh_*_amd64.deb
    rm mongosh_*_amd64.deb
    #For CLoudlfared
    wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb 
    sudo dpkg --install cloudflared-*-amd64.deb
    rm cloudflared-*-amd64.deb
}
install_brew(){
    brew tap mongodb/brew
    brew install mongosh
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
    code-server --force --install-extension ms-azuretools.vscode-docker
}
restore_state(){
    #Restore State
    wget https://github.com/ClassOfCode/test/raw/master/code-server-ga-git.zip && unzip code-server-ga-git.zip
    mkdir /home/runner/.local/ && mkdir /home/runner/.local/share/
    sudo mv code-server /home/runner/.local/share/ && rm code-server-ga-git.zip
    #Make Coder Folder
    sudo mkdir /home/runner/coder/
    sudo chmod -R ugo+rw /home/runner/coder/
    #Restore Logins
    #Git Logins
    sudo git clone $GITLINK
    cd config-files && sudo cp .fly  /home/runner/ -r && sudo cp .local  /home/runner/ -r && sudo cp .netlify  /home/runner/ -r && sudo cp .gitconfig  /home/runner/ -r && sudo cp .netrc /home/runner/ && sudo cp .config /home/runner/ -r && sudo cp .git-credentials /home/runner/ && sudo cp .cloudflared /home/runner/ -r && cd ..
    sudo rm -rf config-files
}
code(){
    code-server --auth none --disable-telemetry /home/runner/coder/
}
tunnel(){
    lt --print-requests --port 8080 -s gcode
}
argo_tunnel(){
    cloudflared tunnel --origincert ~/.cloudflared/cert.pem --config ~/.cloudflared/config.yaml run ga
}

bashrc
install_snapd &
install_scripts
install_apt
install_prog
install_npm
restore_state
install_extensions
code &
argo_tunnel
