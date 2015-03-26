FROM ubuntu:14.04

ENV HOME /root

RUN apt-get update
RUN apt-get -y install pandoc python supervisor wget python-pip python-dev build-essential

RUN pip install pip --upgrade
RUN pip2.7 install ipython[notebook]

RUN sudo apt-get -y install openjdk-7-jre

RUN wget http://dl.bintray.com/sbt/debian/sbt-0.13.6.deb \
	&& sudo dpkg -i sbt-0.13.6.deb \
	&& sudo apt-get update \
	&& sudo apt-get install sbt

RUN apt-get install -y scala

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.3.0/hadoop-2.3.0.tar.gz
RUN tar xfz hadoop-2.3.0.tar.gz
RUN rm hadoop-2.3.0.tar.gz
RUN mv hadoop-2.3.0 /usr/local/hadoop 

RUN wget -q http://wwwftp.ciril.fr/pub/apache/spark/spark-1.3.0/spark-1.3.0-bin-hadoop2.4.tgz
RUN tar -zxvf spark-1.3.0-bin-hadoop2.4.tgz 
RUN rm spark-1.3.0-bin-hadoop2.4.tgz
RUN mv spark-1.3.0-bin-hadoop2.4 /usr/local/spark/

RUN echo "PATH=$PATH:/usr/local/spark" >> ~/.bashrc
RUN echo "PATH=$PATH:/usr/local/hadoop" >> ~/.bashrc

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.3.0.tgz
RUN tar -xvf spark-1.3.0.tgz
RUN rm spark-1.3.0.tgz
RUN mv spark-1.3.0 /usr/local/spark/

RUN mkdir /notebooks
VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888
#CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888
CMD IPYTHON_OPTS="notebook --no-browser --ip=0.0.0.0 --port 8888" /usr/local/spark/bin/pyspark