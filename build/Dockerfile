# Alpine Linux glibc with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV PACKAGE="git" \
    LANG=C.UTF-8 \
    JUPYTER_HOME=/jupyter_notebook \
    BUILD_PACKAGE="gcc musl-dev linux-headers" \
    CONDA_PACKAGE="jupyter dateutil pyyaml pandas scipy cython" \
    PIP_PACKAGE="metakernel_bash metakernel_python redis_kernel"

RUN mkdir -p ${JUPYTER_HOME} && apk add ${PACKAGE} --no-cache
RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install ${PIP_PACKAGE}

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN apk add bash ${BUILD_PACKAGE} --no-cache && \
    pip install jupyter_cms && jupyter cms install --user --symlink --overwrite && \
    jupyter cms activate && \
    git clone https://github.com/damianavila/RISE && cd RISE && python setup.py install

RUN apk del ${BUILD_PACKAGE} --no-cache

EXPOSE 8888

WORKDIR ${JUPYTER_HOME}
CMD jupyter notebook
