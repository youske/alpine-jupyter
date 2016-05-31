# Alpine Linux miniconda with Jupyter php
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="git php zeromq-dev" \
    BUILD_PACKAGE='build-base linux-headers'

USER root
WORKDIR /


# php package
RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool
RUN wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar

# ijavascript kernel
#RUN npm install -g ijavascript

#RUN apk del buildtool --no-cache && rm -rf /tmp/* /var/cache/apk/*

EXPOSE ${PORT}

WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","su","admin","-c","jupyter notebook --no-browser --ip=*"]
