#!/usr/bin/env python
"""
Set position of slider in VLC to <seconds> , first track always selected 
#FIXME should select current track

Enable D-BUS in VLC:
  Tools->Preferences->All switch->Interface->Control Interface-> D-bus control interface
"""
import dbus
import sys

### settings 
PIFACE = 'org.mpris.MediaPlayer2.Player'
TIFACE = 'org.mpris.MediaPlayer2.TrackList'
bus = dbus.SessionBus()
sec_to_usec = lambda x: x*1000000.0
vlc_media_player_obj = bus.get_object("org.mpris.MediaPlayer2.vlc",
                                      "/org/mpris/MediaPlayer2")

properties_manager = dbus.Interface(vlc_media_player_obj,
                                    'org.freedesktop.DBus.Properties')
s = vlc_media_player_obj.get_dbus_method('SetPosition', PIFACE)

### active
p = properties_manager.Get(TIFACE, 'Tracks')
track_id = p[0]
s(track_id, sec_to_usec(int(sys.argv[1])))
