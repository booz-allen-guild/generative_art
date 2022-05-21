FROM python:2.7

RUN apt-get update && apt-get -y install cmake && apt-get -y install qt4-default

RUN apt-get -y install xserver-xorg

RUN apt-get update && apt-get install -y \
	build-essential \
	python \
	python-dev \
	python-qt4 \
	python-qt4-dev \
	pyqt4-dev-tools \
	qt4-designer \
	python-numpy \
	python-pip \
	vim \
	x11-apps \
	xemacs21

ADD . .

RUN pip install -r requirements.txt

# RUN wget https://www.riverbankcomputing.com/static/Downloads/sip/4.19.25/sip-4.19.25.tar.gz
# RUN wget https://www.riverbankcomputing.com/static/Downloads/PyQt4/4.12.3/PyQt4_gpl_x11-4.12.3.tar.gz 

# unzip the files
RUN tar -xvf sip-4.19.25.tar.gz
RUN tar -xvf PyQt4_gpl_x11-4.12.3.tar.gz

WORKDIR /sip-4.19.25

# install the files
RUN python configure.py --sip-module PyQt4.sip
RUN make
RUN make install

WORKDIR /PyQt4_gpl_x11-4.12.3

RUN python configure.py --confirm-license
RUN make
RUN make install

RUN cp sip.pyi /usr/local/lib/python2.7/site-packages/sip.pyi

# WORKDIR /

# This option will run app
# RUN python nsmirror.py
# This option allows you to launch into the command line of the container
CMD ["/bin/bash"]