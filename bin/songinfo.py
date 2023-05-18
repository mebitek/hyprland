#!/usr/bin/env python

import asyncio
import requests
import os
import shutil
from urllib.parse import urlparse

from mopidy_async_client import MopidyClient

async def main():
    async with MopidyClient() as mopidy:  # close connection explicit

        track = await mopidy.playback.get_current_track()
        uri = track['uri']
        name = track['name']
        artist = track['artists'][0]['name']
        album = track['album']['name']

        images = await mopidy.library.get_images([uri])

        image_url = images[uri][0]['uri']

        a = urlparse(image_url)
        print(a)
        file_name = os.path.basename(a.path)
        tmp_file_name = "/tmp/%s"%file_name
    
        print("%s\n%s - %s\n%s"%(name,artist,album,tmp_file_name))

        #if not os.path.isfile(tmp_file_name):

        if not uri.startswith('local'):
           response = requests.get(image_url)
           with open(tmp_file_name, "wb") as f:
               f.write(response.content)
        else:
           home_dir = os.path.expanduser('~')
           src_file = r"%s/.local/share/mopidy/local/images/%s"%(home_dir, file_name)
           shutil.copyfile(src_file, tmp_file_name)

asyncio.run(main())

