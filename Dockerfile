# Alpine Linux glibc with conda
# youske/alpine-conda based

FROM youske/alpine-conda:v3
MAINTAINER youske miyakoshi <youske@gmail.com>
RUN conda install -y jupyter && \
    conda install -y pandas scipy seaborn cython dateutil && \
    conda clean -itpsly
EXPOSE 8000 8080 8088 8888
