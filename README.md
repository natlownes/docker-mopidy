# docker-mopidy

`docker run -p 0.0.0.0:6600:6600 -p 0.0.0.0:6680:6680 -p 0.0.0.0:8002:8002 -e SPOTIFY_USER=natthanield -e SPOTIFY_PASS=very_secret -v /mnt/biggins/music:/home/mopidy/music -i -t narf/mopidy`

*work in progress*

using envtpl to smack all these possible environment vars
into config files
