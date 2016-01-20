==============================================================================
About: Turn signals
==============================================================================

This resource runs 100% server side and will use the current existing lights
of any vehicles as turn indicators.

Usage:
Turn indicators are toggled by the following commands: /lleft, /lright and 
/warn which the user can bind after own perfences later on. All commands saves
the current headlight color into a table indexed by player and change it to 
yellow, after that it start to flash the lights on the given side each 380ms.

Tehnical details:
Cleaning up by stopping timers, clearing tables and reset lights on player 
disconnect. This provides a low performance consuption from the server.

ToDo:
* Index of unsuported vehicles, some aircraft, bikes, boats and trains dosn't 
have lights and won't be able to use these commands, in some cases nothing 
happens, in other cases the wrong lights may flash. It's a low priority bug 
basically which most people won't notice or get affected by.

==============================================================================
License:
==============================================================================

Copyright (c) 2014 MrBrutus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
==============================================================================