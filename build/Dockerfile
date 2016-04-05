# Alpine Linux glibc with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV PACKAGE="bash" \
    BUILD_PACKAGE="git ca-certificates build-base gcc musl-dev linux-headers" \
    LANG=C.UTF-8 \
    JUPYTER_HOME=/jupyter_notebook \
    CONDA_PACKAGE="jupyter dateutil pyyaml pandas scipy cython" \
    PIP_PACKAGE="metakernel_bash metakernel_python redis_kernel"

RUN mkdir -p ${JUPYTER_HOME} && apk add ${PACKAGE} --no-cache
RUN apk add -t buildpack ${BUIILD_PACKAGE} --no-cache

RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install ${PIP_PACKAGE}
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# nbextention & cms & RISE
RUN pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip && \
    pip install jupyter_cms && jupyter cms install --user --symlink --overwrite && \
    jupyter cms activate && \
    git clone https://github.com/damianavila/RISE && cd RISE && python setup.py install

# remove buildpack
RUN apk del buildpack && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8888

WORKDIR ${JUPYTER_HOME}
CMD jupyter notebook
