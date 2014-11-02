[mpd]
hostname = 0.0.0.0

[audio]
output = lame ! shout2send mount=mopidy ip=0.0.0.0 port=8002

[stream]
enabled = true
protocols =
    file
    http
    https
    mms
    rtmp
    rtmps
    rtsp
timeout = 5000

[local]
enabled = true
library = json
media_dir = $XDG_MUSIC_DIR
data_dir = /home/mopidy/data
playlists_dir = home/mopidy/data/mopidy/local/playlists
scan_timeout = 1000
scan_flush_threshold = 1000
excluded_file_extensions =
  .html
  .jpeg
  .jpg
  .log
  .nfo
  .png
  .txt

[http]
enabled = true
hostname = 0.0.0.0
port = 6680
static_dir = /home/mopidy/src/webclients/moped/dist

{% if LASTFM_USER is defined %}


{% endif %}

{% if SPOTIFY_USER is defined %}
[spotify]
enabled  = true
username = {{SPOTIFY_USER}}
password = {{SPOTIFY_PASS}}
bitrate  = 320
{% endif %}
