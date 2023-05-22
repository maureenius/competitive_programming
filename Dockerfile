FROM centos:6.9

RUN yum install -y gcc-c++ cmake openssh-server rsync centos-release-scl
RUN yum install -y devtoolset-6-gdb

RUN curl -L https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh -o ./cmake3.sh
RUN chmod +x ./cmake3.sh
RUN ./cmake3.sh --skip-license --exclude-subdir --prefix=/usr/local

RUN passwd -d root

RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

#RUN sed -i 's/exec/#exec/' /etc/init/tty.conf
RUN sed -i 's/ACTIVE_CONSOLES=\/dev\/tty\[1-6\]/ACTIVE_CONSOLES=/' /etc/sysconfig/init

RUN /etc/init.d/sshd start
CMD ["/sbin/init"]