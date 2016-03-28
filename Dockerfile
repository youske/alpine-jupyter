# Alpine Linux glibc with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV LANG=C.UTF-8 \
    CONDA_INSTALL="jupyter"
#    CONDA_INSTALL="jupyter pandas scipy cython dateutil"

RUN addgroup -S jupyter && adduser -S -G jupyter jupyter && \
    conda install -y ${CONDA_INSTALL} && \
    conda clean -itpsly

COPY entrypoint.sh /docker-entrypoint.sh
COPY jupyter_notebook_config.py /home/jupyter/.jupyter/jupyter_notebook_config.py

ENTRYPOINT ["/docker-entrypoint.sh"]
VOLUME /home/jupyter
WORKDIR /home/jupyter
CMD ["jupyter", "notebook"]

EXPOSE 8888
