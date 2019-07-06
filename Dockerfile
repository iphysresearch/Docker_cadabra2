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
