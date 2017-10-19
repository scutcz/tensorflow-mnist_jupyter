FROM acezchen/tensorflow-mnist
MAINTAINER Ace Chen 272716025@qq.com

# Install dependence

RUN apt-get update && \

    apt-get install -y --no-install-recommends build-essential cmake \
    libopenblas-dev \
    libjpeg-dev zlib1g-dev && \
           
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*


# Jupyter

RUN pip3 --no-cache-dir install Pillow \
    
    numpy scipy sklearn scikit-image pandas && \

    pip3 install jupyter && \
    
    mkdir /root/.jupyter && \
    echo "c.NotebookApp.ip = '*'" \
         "\nc.NotebookApp.open_browser = False" \
         "\nc.NotebookApp.token = ''" \
         > /root/.jupyter/jupyter_notebook_config.py && \
    
    pip3 install jupyter_contrib_nbextensions \
    
    yapf && \
    
    jupyter contrib nbextension install --user && \
    
    jupyter nbextension enable code_prettify/code_prettify


EXPOSE 8888

COPY run_jupyter.sh /

CMD ["/run_jupyter.sh", "--allow-root"]
