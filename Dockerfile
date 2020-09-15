FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

RUN apt-get update 
# Install jupyter.
RUN pip install --no-cache-dir jupyter jupyterlab
RUN pip install --no-cache-dir jupyter_http_over_ws ipykernel nbformat nbconvert
RUN jupyter serverextension enable --py jupyter_http_over_ws
RUN mkdir /.local && chmod a+rwx /.local
RUN mkdir /.jupyter && chmod a+rwx /.jupyter
# Install libraries.
RUN pip install --no-cache-dir matplotlib Pillow opencv-python
RUN pip install --no-cache-dir tqdm pandas
RUN apt-get install -y libglu1
RUN mkdir /.config && chmod a+rwx /.config
RUN mkdir /.cache && chmod a+rwx /.cache
RUN mkdir /.pytorch && chmod a+rwx /.pytorch
# Install tex for enable pdf print using tex.
RUN apt-get install -y --no-install-recommends pandoc texlive-xetex texlive-fonts-recommended texlive-generic-recommended
RUN apt-get autoremove -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy files.
WORKDIR /workspace
COPY . .
RUN chmod -R a+rwx /workspace

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--notebook-dir=/workspace"]
