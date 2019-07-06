Docker image for Cadabra2 [https://cadabra.science](https://cadabra.science)

### Usage

> Ref: [Docker for Mac and GUI applications](https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/)

1. Install XQuartz

``` bash
brew cask install xquartz
```

2. Open XQuartz

``` bash
open -a XQuartz
```

3. Configuration

``` bash
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip
```

4. Run

``` bash
docker run -d --name cadabra2 -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix iphysresearch/cadabra2_docker:2.2.7
```

### Tags

- Tags: 2.2.7:  **Cadabra2** version **2.2.7** (build 2134.2c4993dd63 dated **2019-06-12**)

### Dockerfile

Built from [stewartmh/cadabra2-build](https://hub.docker.com/r/stewartmh/cadabra2-build)

``` dockerfile
FROM stewartmh/cadabra2-build
USER root
RUN apt update 
RUN DEBIAN_FRONTEND=noninteractive apt install -y sudo git cmake python3-dev \
      g++ libpcre3 libpcre3-dev libgmp3-dev \
      libgtkmm-3.0-dev libboost-all-dev libgmp-dev libsqlite3-dev uuid-dev  \
      texlive texlive-latex-extra dvipng \
      python3-matplotlib python3-mpmath python3-pip python3-setuptools
RUN sudo pip3 install sympy
RUN rm -rf cadabra2/
RUN git clone https://github.com/kpeeters/cadabra2
RUN cd cadabra2
RUN mkdir build;cd build
RUN cmake ..
RUN make
RUN sudo make install
RUN ctest
ENTRYPOINT ["cadabra2-gtk"]
```
