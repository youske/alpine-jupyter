# Alpine Linux miniconda with Jupyter
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="git elixir erlang erlang-tools erlang-stdlib erlang-ssh erlang-mnesia erlang-crypto erlang-syntax-tools erlang-kernel erlang-compiler"

USER root
WORKDIR /

# elixir & erlang package
RUN apk update --no-cache && apk add ${PACKAGE} --no-cache

# IElixir kernel
RUN git clone https://github.com/pprzetacznik/IElixir.git
#&& \
#    cd IElixir && mix deps.get && mix test && MIX_ENV=prod mix compile

COPY kernel.json /home/admin/.ipython/kernels/ielixir/kernel.json

EXPOSE ${PORT}

USER admin
WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=/bin/bash","--","sh","-c","jupyter notebook --no-browser --ip=* "]
