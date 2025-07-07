# r3_prospecting
#### A handler for glitchdetectors prospecting minigame made to work with QBCore and ESX

This uses r3_servicesmanager to support every framework that registers itself properly as a provider.

## Features
* Randomly generated treasure within a pre-defined area
* Infinitely re-generating treasure
* Multiplayer support
* Items found come in your inventory

## How to use

A new area will be marked on the map

1. Go to the marked area
2. Use the detector item
3. Walk around while paying attention to the scanner
4. Locate and dig out treasure

You have to find a way to give players the detector item, it is the easiest to just add it to one of your stores but thats up to you.

## Dependencies
* [Prospecting](https://github.com/glitchdetector/fivem-prospecting)
* An inventory, usableItems and notification provider registered within r3_servicesmanager.

## Download & Installation

### Manually
- Download this resource and put it in your resources folder.

## Installation
- Add this to your `server.cfg`:

```
ensure r3_prospecting
```
- Add the items to your core or inventory script.

## Credits
This resource was made from [glitchdetectors example handler](https://github.com/glitchdetector/fivem-prospecting-example).

## Discord:
If you want to contact me or require help you could join my discord server, I can't guarantee that I will be able to help you.
* [Discord Server](https://discord.gg/bEWmBbg)

## Legal

I'll paste something regarding a license down here.
Any changes to this script should link back to me. You can always make a pull request if you have good extra stuff.

### License
r3_prospecting - Prospecting handler.

Copyright (C) 2025 r3ps4J

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
