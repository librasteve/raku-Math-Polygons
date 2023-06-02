FROM librasteve/rakudo:notebook-arm64-2021.05
    
RUN zef install -v Math::Polygons \ 
    && git clone https://github.com/librasteve/raku-Math-Polygons.git \
    && cp -R raku-Math-Polygons/eg /

ENTRYPOINT ["/bin/bash"]

EXPOSE 8888

#CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
