#!/usr/bin/env python

import requests
import json
from urllib.parse import urlparse
import os

class MopidyClient:
    def __init__(self, host='localhost', port=6680):
        self.url = f"http://{host}:{port}/mopidy/rpc"
        self.headers = {'Content-Type': 'application/json'}

    def _send_command(self, method, params=None):
        payload = {
            "method": method,
            "jsonrpc": "2.0",
            "params": params or {},
            "id": 1
        }
        try:
            response = requests.post(self.url, data=json.dumps(payload), headers=self.headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            return {"error": f"Errore di connessione: {e}"}

    def get_current_track_details(self):
        """Restituisce i dettagli completi inclusi URI traccia e URI album."""
        data = self._send_command("core.playback.get_current_track")
        
        if "result" in data and data["result"]:
            track = data["result"]
            album = track.get('album', {})
            artists = ", ".join([a['name'] for a in track.get('artists', [])])
            
            return {
                "title": track.get("name", "Sconosciuto"),
                "artist": artists,
                "track_uri": track.get("uri"),
                "album_name": album.get("name", "Sconosciuto"),
                "album_uri": album.get("uri"),  # <--- Ecco l'URI dell'album
                "date": album.get("date", "N/A")
            }
        return None

    def get_album_images(self, album_uri):
        """Recupera gli URL delle immagini gestendo potenziali mancanze di dati."""
        if not album_uri:
            return []
        data = self._send_command("core.library.get_images", {"uris": [album_uri]})
        
        image_list = data.get("result", {}).get(album_uri, [])
        
        cleaned_images = []
        for img in image_list:
            link = img.get('uri') or img.get('url')
            if link:
                cleaned_images.append(link)
        
        return cleaned_images


if __name__ == "__main__":
    mopidy = MopidyClient(host='localhost')
    
    info = mopidy.get_current_track_details()
    
    if info:
        name = info['title']
        artist = info['artist']
        album = info['album_name']

        images = mopidy.get_album_images(info['album_uri'])
        tmp_file_name ="" 
        image_url = None
        if images:
            image_url = images[0]
            with requests.get(image_url, stream=True, timeout=10) as r:
                r.raise_for_status()
                with open("/tmp/Primary", 'wb') as f:
                    for chunk in r.iter_content(chunk_size=8192):
                        f.write(chunk)
            a = urlparse(image_url)
            file_name = os.path.basename(a.path)
            tmp_file_name = "/tmp/%s"%file_name


        print("%s\n%s - %s\n%s"%(name,artist,album,tmp_file_name))

        
    else:
        print("Nessuna traccia in riproduzione.")
