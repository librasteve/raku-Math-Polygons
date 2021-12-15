FROM sumankhanal/rakudo:2021.05
#FROM p6steve/rakudo:ubuntu-arm64-2021.05

LABEL maintainer="Dr Suman Khanal <suman81765@gmail.com>"

#Enabling Binder..................................

ENV NB_USER suman
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
#..............................................
      
ENV PATH=$PATH:/usr/share/perl6/site/bin

RUN apt-get update \
    && apt-get install -y build-essential \
    wget libzmq3-dev ca-certificates \
    python3-pip python3-setuptools \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install jupyter notebook asciinema jupyterlab pyscaffold --no-cache-dir \
    && zef -v install git://github.com/bduggan/p6-jupyter-kernel.git --force-test \ 
    && zef install Pod::To::HTML \
    && jupyter-kernel.raku --generate-config \
    && ln -s /usr/share/perl6/site/bin/* /usr/local/bin

RUN zef install -v Math::Polygons \ 
    && git clone https://github.com/p6steve/raku-Math-Polygons.git \
    && cp -R raku-Math-Polygons/eg ${HOME}

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini 
ENTRYPOINT ["/usr/bin/tini", "--"]
#ENTRYPOINT ["/bin/bash"]


#For enabling binder..........................
#COPY ./raku-notebooks/ ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}
#..............................................

EXPOSE 8888

#CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
