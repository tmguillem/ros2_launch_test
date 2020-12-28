FROM ros:foxy

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update \
  && apt-get clean \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends apt-utils
  
RUN apt-get install software-properties-common -y \
    && apt-add-repository universe  -y

RUN apt-get install python3-pip -y \
    && pip3 install python-geoip \
    && pip3 install python-geoip-geolite2 \
    && apt-get install python2 -y


RUN  apt-get install doxygen -y 



RUN pip3 install Sphinx

RUN pip3 install exhale \
    && pip3 install sphinx-rtd-theme \
    && pip3 install m2r \
    && pip3 install m2r2 \
    && pip3 install breathe 

RUN pip3 install numpy 
RUN pip3 install scipy 
RUN pip3 install pybullet 
RUN pip3 install jupyterlab
RUN pip3 install ipympl
RUN pip3 install pyswarms
RUN pip3 install nodejs
RUN pip3 install jupyter

ENTRYPOINT ["/entrypoint.sh"]