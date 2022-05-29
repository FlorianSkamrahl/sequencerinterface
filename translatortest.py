#!/usr/bin/env python
#
# midiin_poll.py
#
"""Show how to receive MIDI input by polling an input port."""

from __future__ import print_function

import logging
import sys
import time

from rtmidi.midiutil import open_midiinput
from rtmidi.midiutil import open_midioutput
from rtmidi.midiconstants import NOTE_OFF, NOTE_ON, CONTROL_CHANGE


log = logging.getLogger('midiin_poll')
logging.basicConfig(level=logging.DEBUG)

# Prompts user for MIDI input port, unless a valid port number or name
# is given as the first argument on the command line.
# API backend defaults to ALSA on Linux.
#port = sys.argv[1] if len(sys.argv) > 1 else None

try:
    midiout, port_name_out  = open_midioutput(2)
    midiin, port_name_in= open_midiinput(0)
    print(port_name_in, port_name_out)
except (EOFError, KeyboardInterrupt):
    sys.exit()

note_on = [NOTE_ON, 60, 112]  # channel 1, middle C, velocity 112
note_off = [NOTE_OFF, 60, 0]

fader_right = [CONTROL_CHANGE, 0,  127]
fader_left = [CONTROL_CHANGE, 0,  0]



#with midiout:
#    print("Sending NoteOn event.")
#    midiout.send_message(fader_right)
#    time.sleep(1)
#    print("Sending NoteOff event.")
#    midiout.send_message(fader_left)
#    time.sleep(0.1)

#del midiout
#print(NOTE_ON)

print("Entering main loop. Press Control-C to exit.")
try:
    timer = time.time()
    with midiout:
        while True:
            msg = midiin.get_message()

            if msg:
                message, deltatime = msg
                timer += deltatime
                event, chan, value = message
                print(event, chan, value )
                #print("[%s] @%0.6f %r" % (port_name_in, timer, message))
                if event == 155:
                    if chan == 36:
                        print("jooooo")
                        midiout.send_message(fader_right)
                        time.sleep(0.1)

                elif event == 139:
                    if chan == 36:
                        print("nooooo")
                        midiout.send_message(fader_left)
                        time.sleep(0.1)

            time.sleep(0.01)
except KeyboardInterrupt:
    print('')
finally:
    print("Exit.")
    midiin.close_port()
    del midiin