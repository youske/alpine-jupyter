# Alpine Linux glibc with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8
ENV PACKAGE='' \
    BUILD_PACKAGE='wget git ca-certificates build-base musl-dev linux-headers' \
    CONDA_PACKAGE='jupyter dateutil pyyaml pandas scipy numpy cython' \
    PIP_PACKAGE='metakernel_bash metakernel_python redis_kernel'

RUN apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildpack
RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install ${PIP_PACKAGE}

# nbextention & cms & RISE
RUN pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip && \
    pip install jupyter_cms && jupyter cms install --user --symlink --overwrite && jupyter cms activate && \
    git clone https://github.com/damianavila/RISE && cd RISE && python setup.py install

# remove buildpack
RUN apk del buildpack --no-cache && rm -rf /tmp/* /var/cache/apk/*

RUN mkdir -p ${JUPYTER_HOME} && mkdir -p /home/admin/.jupyter
COPY jupyter_notebook_config.py /home/admin/.jupyter/jupyter_notebook_config.py
RUN chown -R admin:admin ${JUPYTER_HOME} /home/admin

EXPOSE 8888

USER admin
WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["switch","shell=/bin/bash","--","jupyter","notebook"]
