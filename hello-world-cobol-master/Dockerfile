FROM ubuntu:15.04
MAINTAINER Yonas Yanfa

WORKDIR /root
RUN apt-get update && apt-get install vim-tiny open-cobol -y
ADD . /root
RUN cobc -free -x -o /root/hello-world /root/hello-world.cbl
CMD bash -C '/root/run.sh';'bash'
