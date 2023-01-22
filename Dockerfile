FROM debian:latest
WORKDIR /home/projects

# Install basic packages.
RUN apt-get update
RUN apt-get install -y gcc g++ make
RUN apt-get install -y software-properties-common zsh curl wget git htop unzip vim telnet less
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install oh-my-zsh and define zsh as default shell
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true &&\
    chsh -s /bin/zsh

# Apply custom theme, disable auto-update and fix backspace displaying space in the prompt
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="candy"/g' /root/.zshrc &&\
    sed -i 's/# DISABLE_AUTO_UPDATE=true/DISABLE_AUTO_UPDATE=true/g' /root/.zshrc &&\
    echo TERM=xterm >> /root/.zshrc

CMD ["/bin/zsh"]