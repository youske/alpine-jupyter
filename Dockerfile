# Alpine Linux glibc with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV PACKAGE="git" \
    LANG=C.UTF-8 \
    JUPYTER_HOME=/jupyter_notebook \
    CONDA_PACKAGE="jupyter dateutil pyyaml pandas scipy cython" \
    PIP_PACKAGE="metakernel_bash metakernel_python redis_kernel"

RUN mkdir -p ${JUPYTER_HOME} && apk add ${PACKAGE} --no-cache
RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install ${PIP_PACKAGE}

COPY entrypoint.sh /docker-entrypoint.sh
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py


RUN apk add git gcc musl-dev --no-cache && \
    pip install jupyter_cms && jupyter cms install --user --symlink --overwrite && \
    jupyter cms activate && jupyter cms help && \
    git clone https://github.com/damianavila/RISE && cd RISE && python setup.py install
    #apk remove gcc musl-dev


WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["jupyter"]
EXPOSE 8888
