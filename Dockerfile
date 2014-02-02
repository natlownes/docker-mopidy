FROM ubuntu:raring
MAINTAINER Nat Lownes <nat.lownes@gmail.com>

# must run in privileged mode (-privileged)

RUN apt-get -qq update
RUN apt-get install -y wget software-properties-common
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

ADD policy-rc.d /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/mopidy.list

RUN apt-get -qq update


RUN apt-get install -y bash git mopidy mopidy-spotify dbus icecast2 nfs-common nfs-client python-pip
#RUN pip install cherrypy>=3.2.2

RUN mkdir -p /home/mopidy/src/webclients
RUN mkdir -p /home/mopidy/data
RUN mkdir -p /home/mopidy/music

RUN git clone https://github.com/martijnboland/moped.git /home/mopidy/src/webclients/moped

ADD mopidy.conf /home/mopidy/mopidy.conf
ADD start.sh /home/mopidy/start.sh

RUN chown -R mopidy /home/mopidy
RUN chmod +x /home/mopidy/start.sh


EXPOSE 6680

ENTRYPOINT /home/mopidy/start.sh
