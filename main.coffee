#
# The same idea as the 'Cool streams' script but with the
# radio stations I use to listen.
#
# Author:: Copyright (C) 2011  Miquel Sabaté (mikisabate@gmail.com)
# License::
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
#


# Import Qt bindings
Importer.loadQtBinding 'qt.core'
Importer.loadQtBinding 'qt.gui'


# Represents a Station. It just defines the _name_ and _url_ attributes.
class Station
  constructor: (@name, @url) ->


# The following is an array with all the stations I want to be displayed.
stations = [
  new Station('Afterhours.FM [Trance/Livesets]', 'http://www.ah.fm/192k.m3u'),
  new Station('Digitally Imported - Trance', 'http://di.fm/mp3/trance.pls'),
  new Station('Digitally Imported - Happy Hardcore', 'http://www.di.fm/mp3/hardcore.pls'),
  new Station('Digitally Imported - Classic Techno', 'http://www.di.fm/mp3/classictechno.pls'),
  new Station('ErrorFM - Live', 'http://www.errorfm.com/efm8005.pls'),
  new Station('ErrorFM - Indiepop', 'http://www.errorfm.com/efm8002.pls'),
  new Station('Ràdio Flaixbac', 'http://flaix.stream.flumotion.com/flaix/flaixbac.mp3.m3u'),
  new Station('Catalunya Ràdio', 'http://www.catradio.cat/directes/catradio_http.m3u'),
  new Station('Catalunya Informació', 'http://www.catradio.cat/directes/catinfo_http.m3u'),
  new Station('m80 Radio', 'http://94.75.234.135:8883')
]


# Description for this script
mRadio = ->
  ScriptableServiceScript.call this, 'mRadio', 1, 'Les radios que sols escoltar al teu avast', 'Emisions en directe', false
  Amarok.debug 'ok.'


# On populating we'll create a list with all our stations.
onPopulating = (level, callbackData, filter) ->
  for station in stations
    item = Amarok.StreamItem
    item.level = 0
    item.callbackData = ''
    item.itemName = station.name
    item.playableUrl = station.url
    item.infoHtml = 'Un stream anomenat ' + station.name
    script.insertItem item
  script.donePopulating()


# On customize let's set a fancy icon.
onCustomize = ->
  currentDir = Amarok.Info.scriptPath() + '/'
  iconPixmap = new QPixmap currentDir + 'icon.png'
  script.setIcon iconPixmap


# And now it's time to create the mRadio instance.
script = new mRadio()
script.populate.connect onPopulating
script.customize.connect onCustomize

