FROM continuumio/miniconda3:4.7.10
ENV GWPY_VERSION="0.15.0"

LABEL name="GWpy" \
      maintainer="Duncan Macleod <duncan.macleod@ligo.org>" \
      support="Best Effort" \
      version="${GWPY_VERSION}"

RUN /opt/conda/bin/conda config --system --prepend channels conda-forge && \
    /opt/conda/bin/conda config --system --append channels lscsoft

RUN /opt/conda/bin/conda create --name gwpy \
        "gwpy=${GWPY_VERSION}" \
        "maya" \
        "pandas" \
        "python=3.7" \
        "python-lalsimulation" \
        "python-ldas-tools-framecpp" \
        "python-ligo-lw>=1.5.0" \
        "python-nds2-client" \
    && \
    /opt/conda/bin/conda clean -afy && \
    sed -i "s|activate base|activate gwpy|g" ~/.bashrc

COPY entrypoint /opt/conda/bin/entrypoint
ENTRYPOINT ["/opt/conda/bin/entrypoint"]
CMD ["/bin/bash"]
