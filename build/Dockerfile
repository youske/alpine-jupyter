# Alpine Linux miniconda with Jupyter
# youske/alpine-conda based

FROM youske/alpine-conda:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8\
    PORT=8888
ENV PACKAGE='gawk git ca-certificates ' \
    BUILD_PACKAGE='wget build-base musl-dev linux-headers' \
    CONDA_PACKAGE='jupyter matplotlib dateutil pyyaml pymysql sqlalchemy psycopg2 pandas scipy numpy cython bokeh xlrd xlutils openpyxl' \
    PIP_PACKAGE='metakernel_bash metakernel_python redis_kernel pandas-td pandas-datareader '

RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildpack
RUN conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly
RUN pip install ${PIP_PACKAGE}

# nbextention & cms & RISE
RUN pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip && \
#    pip install jupyter_cms && jupyter cms install --user --symlink --overwrite && jupyter cms activate && \
    git clone https://github.com/damianavila/RISE && cd RISE && python setup.py install

# remove buildpack
RUN apk del buildpack --no-cache && rm -rf /tmp/* /var/cache/apk/*

RUN mkdir -p ${JUPYTER_HOME} && mkdir -p /home/admin/.jupyter && mkdir -p /home/admin/.ipython/profile_default
COPY jupyter_notebook_config.py.tmpl /home/admin/.jupyter/jupyter_notebook_config.py.tmpl
COPY ipython_config.py.tmpl /home/admin/.ipython/profile_default/ipython_config.py.tmpl
RUN chown -R admin:admin ${JUPYTER_HOME} /home/admin

EXPOSE ${PORT}

WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","su","admin","-c","jupyter notebook --no-browser --ip=*"]
