ARG DOCKER_NOTEBOOK_IMAGE
FROM $DOCKER_NOTEBOOK_IMAGE

ENV PATH=$PATH:$HOME/.local/bin:$HOME/bin

ARG JUPYTERHUB_VERSION
RUN python3 -m pip install --no-cache jupyterhub==$JUPYTERHUB_VERSION && \
    python3 -m pip install --upgrade jupyter_core jupyter_client && \
    /opt/conda/bin/conda install -c conda-forge conda=4.8.3 nbgrader jupyterlab-dash=0.1.0a3 && \
    /opt/conda/bin/conda install -c conda-forge jupyterlab=$JUPYTERLAB_VERSION && \
    jupyter labextension install @j123npm/jupyterlab-dash@0.1.0-alpha.4 && \
    python3 -m pip install --upgrade jupyterlab-git && \
    jupyter lab build


USER root

COPY ./bin/start-custom.sh /usr/local/bin
COPY ./bin/start-singleuser-custom.sh /usr/local/bin
COPY ./nbgrader_config.py /etc/jupyter
COPY ./students.csv /tmp
# This line is necessary because in the start script we delete user jovyan and without this line wordir is /home/jovyan
WORKDIR /root
