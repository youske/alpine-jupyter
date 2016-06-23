# Alpine Linux miniconda with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8\
    PORT=8888
ENV PACKAGE='sudo gawk git ncurses ca-certificates' \
    BUILD_PACKAGE='wget build-base musl-dev linux-headers' \
    CONDA_PACKAGE='jupyter matplotlib dateutil pyyaml pymysql sqlalchemy psycopg2 pandas scipy numpy cython bokeh xlrd xlutils openpyxl ipywidgets' \
    PIP_PACKAGE='psutil jupyter_cms metakernel_bash metakernel_python redis_kernel pandas-td pandas-datareader ' \
    WIDGET_PACKAGE='ipyleaflet bqplot pythreejs'

RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildpack
RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install -U ${PIP_PACKAGE} ${WIDGET_PACKAGE}

# cms
RUN jupyter cms quick-setup --sys-prefix && \
    jupyter nbextension enable jupyter_cms --py --sys-prefix && \
    jupyter nbextension enable --py ipyleaflet && \
    jupyter nbextension enable --py bqplot && \
    jupyter nbextension enable --py pythreejs && \
    jupyter nbextension enable --py widgetsnbextension


WORKDIR /tmp

# jupyter-drive
RUN git clone https://github.com/jupyter/jupyter-drive.git && \
    pip install -e jupyter-drive && \
    python -m jupyterdrive --mixed

USER admin

RUN mkdir -p /home/admin/.jupyter && mkdir -p /home/admin/.ipython/profile_default
COPY jupyter_notebook_config.py.tmpl /home/admin/.jupyter/jupyter_notebook_config.py
#COPY jupyter_notebook_config.json /home/admin/.jupyter/jupyter_notebook_config.json
COPY ipython_config.py.tmpl /home/admin/.ipython/profile_default/ipython_config.py

# RISE
RUN git clone https://github.com/damianavila/RISE && \
    cd RISE && python setup.py install

# nbextention
RUN git clone https://github.com/ipython-contrib/IPython-notebook-extensions
#&& \
#    cd IPython-notebook-extensions && python setup.py install

USER root

# remove buildpack
RUN apk del buildpack --no-cache && rm -rf /tmp/* /var/cache/apk/*

EXPOSE ${PORT}
WORKDIR /home/admin
ENTRYPOINT ["switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","/init"]
CMD ["gosu","admin","jupyter", "notebook", "--no-browser","--ip=*"]
