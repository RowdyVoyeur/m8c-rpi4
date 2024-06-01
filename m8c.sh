#!/bin/bash

# Check if the Instrument with the Card Name "MC101" is connected to the Raspberry Pi
# Use "aplay -l" to find the Card Name of any connected audio devices
if [ $(aplay -l | grep -c "MC101") -eq 0 ]; then
  echo "MC101 not detected, skipping connection."
else
  echo "MC101 detected, connecting."

# Open audio interface between the Instrument Out and System In
# alsa_in options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
alsa_in -j "MC101_in" -d hw:CARD=MC101,DEV=0 -r 44100 -p 64 -n 4 &

# Open audio interface between System Out and Instrument In
# alsa_out options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
# Important: If using MC-101 in Vendor driver mode, then comment the following line
alsa_out -j "MC101_out" -d hw:CARD=MC101,DEV=0 -r 44100 -p 64 -n 4 &

sleep 2

# Connect audio of Instrument Out to System In (This allows to hear the additional Instrument)
jack_connect MC101_in:capture_1 system:playback_1
jack_connect MC101_in:capture_2 system:playback_2

# Connect audio of USB Card Microphone or Audio Card In to MC101 In (This allows to record audio onto the additional Instrument)
# Important: If using MC-101 in Vendor driver mode, then comment the following lines
jack_connect system:capture_1 MC101_out:playback_1
# Comment the following line and uncomment the next one, if your USB Card or Audio Card In has a mono ADC
jack_connect system:capture_2 MC101_out:playback_2
# jack_connect system:capture_1 MC101_out:playback_2

# Start MIDI To Command (Uncomment the line below to start midi-to-command on boot. More info: github.com/RowdyVoyeur/midi-tools)
# sudo python home/patch/midi-tools/midi-to-command/midi2command.py home/patch/midi-tools/midi-to-command/config.cfg -p nanoKONTROL &

fi

# Open audio interface between M8 Out and System In
# alsa_in options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
alsa_in -j "M8_in" -d hw:CARD=M8,DEV=0 -r 44100 -p 64 -n 4 &

# Open audio interface between System Out and M8 In
# alsa_out options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
alsa_out -j "M8_out" -d hw:CARD=M8,DEV=0 -r 44100 -p 64 -n 4 &

sleep 2

# Connect audio of M8 Out to System In (This allows to hear the M8)
jack_connect M8_in:capture_1 system:playback_1
jack_connect M8_in:capture_2 system:playback_2

# Connect audio of USB Card Microphone or Audio Card In to M8 In (This allows to record audio onto the M8)
jack_connect system:capture_1 M8_out:playback_1
# Comment the following line and uncomment the next one, if your USB Card or Audio Card In has a mono ADC
jack_connect system:capture_2 M8_out:playback_2
# jack_connect system:capture_1 M8_out:playback_2

# Start CC to Note (Uncomment the line below to start cc-to-note on boot. More info: github.com/RowdyVoyeur/midi-tools)
# sudo python /home/patch/midi-tools/cc-to-note/main.py --config /home/patch/midi-tools/cc-to-note/config.json &

# Start Control Alsamixer (Uncomment the following line to start control-amixer on boot. More info: github.com/RowdyVoyeur/midi-tools)
# sudo /bin/bash /home/patch/midi-tools/control-amixer/control-amixer.sh &

# Start M8C
pushd /home/patch/m8c-rpi4
./m8c
popd

# Clean up audio routing
killall -s SIGINT alsa_out alsa_in

# Shutdown after quitting M8C
sleep 2
sudo shutdown now
