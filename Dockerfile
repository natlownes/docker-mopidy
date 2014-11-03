FROM ubuntu:trusty
MAINTAINER Nat Lownes <nat.lownes@gmail.com>

# must run in privileged mode (-privileged)

RUN apt-get -qq update
RUN apt-get install -y wget
RUN apt-get install -y software-properties-common
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

#ADD policy-rc.d /usr/sbin/policy-rc.d
#RUN chmod +x /usr/sbin/policy-rc.d

RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/mopidy.list

RUN apt-get -qq update

# take environment variables and interpolate them in config files
RUN apt-get install -y python-pip
RUN pip install envtpl

RUN apt-get install -y bash
RUN apt-get install -y git
RUN apt-get install -y mopidy
RUN apt-get install -y mopidy-spotify
RUN apt-get install -y mopidy-soundcloud
RUN apt-get install -y mopidy-scrobbler
RUN apt-get install -y dbus
RUN apt-get install -y icecast2
RUN apt-get install -y lame
RUN apt-get install -y libspotify12
RUN apt-get install -y python-spotify
RUN apt-get install -y nfs-common
RUN apt-get install -y nfs-client
#RUN pip install cherrypy>=3.2.2

RUN mkdir -p /home/mopidy/src/webclients
RUN mkdir -p /home/mopidy/data
RUN mkdir -p /home/mopidy/music

RUN git clone https://github.com/martijnboland/moped.git /home/mopidy/src/webclients/moped

ADD usr/share/icecast2/web/2sec.mp3 /usr/share/icecast2/web/2sec.mp3
ADD usr/share/icecast1/web/1sec.mp3 /usr/share/icecast1/web/1sec.mp3
RUN chown -R icecast2 /usr/share/icecast2

ADD etc/icecast2/icecast.xml /etc/icecast2/icecast.xml
RUN chown -R icecast2 /etc/icecast2

ADD templates /home/mopidy/templates
ADD start.sh /home/mopidy/start.sh

RUN chown -R mopidy /home/mopidy
RUN chmod +x /home/mopidy/start.sh


EXPOSE 6600
EXPOSE 6680
EXPOSE 8000
EXPOSE 8002

ENTRYPOINT /home/mopidy/start.sh
