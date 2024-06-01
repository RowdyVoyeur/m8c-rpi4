# Configure Audio

## Patchbox OS Setup Wizard

This fork assumes you're running [Blokas Patchbox OS](https://blokas.io/patchbox-os/). Therefore, you need to configure the default sound card using the `Setup Wizard`. You can launch the `Setup Wizard` at any time by typing `patchbox` in Terminal.

According to Blokas [website](https://blokas.io/patchbox-os/docs/setup-wizard/), the recommended JACK settings for USB audio cards are a Sampling Rate of 44,100 Hz, a Buffer Size of 512 and a Period of 3.

However, if you're using a Raspberry Pi 4 Model B with 1Gb RAM or higher and a USB sound card with [this chip](https://datasheet.lcsc.com/lcsc/1912111437_Cmedia-HS-100B_C371351.pdf) or anything better you should be able to run with a `Sampling Rate` of 48,000 Hz, a `Buffer Size` of 64 and a `Period` between 2 and 4 (this will largely depend on the sound card you are using).

Based on my experiments, a setup consisting of M8 (using audio in/out) and MC-101 (connected via USB) will perform consistently well and without undesired audio artifacts using a `Sampling Rate` of 44,100 Hz, a `Buffer Size` of 64 and a `Period` of 4. This configuration should give you about 6 ms of nominal latency according to [this link](https://wiki.linuxaudio.org/wiki/list_of_jack_frame_period_settings_ideal_for_usb_interface). This latency should not be a problem unless you want to play the instruments with a keyboard or if you connect this setup to additional gear. Both the M8 and the MC-101 have the same latency, therefore you generally won't notice it until you connect something to the audio input.

## Connections

If your USB sound card and/or your additional USB Class Compliant instrument(s) support USB 3.0, then you should connect them to the `blue` USB ports of your [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/). This may help reduce audio latency and improve the overall performance of the setup.

The [Teensy 4.1](https://www.pjrc.com/store/teensy41.html) only supports USB 2.0 (480 Mbit/sec). Therefore, it can be connected to the `black` USB ports of your [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/).

## M8C Bash Script

After configuring the default sound card using the `Setup Wizard`, you will need to configure [this script](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh) according to your preferences. This script is responsible for connecting the audio in/out of the M8 and/or other connected instruments to the default sound card selected in the `Setup Wizard`.

Therefore, for optimal performance, the `alsa_in` / `alsa_out` options of the connected devices should match those selected in the `Setup Wizard`. So, for example, if you selected a `Sampling Rate` of 44,100 Hz, a `Buffer Size` of 64 and a `Period` of 4 in the `Setup Wizard`, then the `alsa_in` / `alsa_out` should look like this for M8:
```
alsa_in -j "M8_in" -d hw:CARD=M8,DEV=0 -r 44100 -p 64 -n 4 &
alsa_out -j "M8_out" -d hw:CARD=M8,DEV=0 -r 44100 -p 64 -n 4 &
```
And like this for the MC-101 or any other USB Class Compliant instrument you plan to connect (don't forget to change the device name `MC101` if you're using a different device):
```
alsa_in -j "MC101_in" -d hw:CARD=MC101,DEV=0 -r 44100 -p 64 -n 4 &
alsa_out -j "MC101_out" -d hw:CARD=MC101,DEV=0 -r 44100 -p 64 -n 4 &
```
Alternatively, you can simply delete those options and let the system use its default values. In that case, the `alsa_in` / `alsa_out` should look like this for M8:
```
alsa_in -j "M8_in" -d hw:CARD=M8,DEV=0 &
alsa_out -j "M8_out" -d hw:CARD=M8,DEV=0 &
```
And like this for the MC-101 or any other USB Class Compliant instrument you plan to connect (don't forget to change the device name `MC101` if you're using a different device):
```
alsa_in -j "MC101_in" -d hw:CARD=MC101,DEV=0 &
alsa_out -j "MC101_out" -d hw:CARD=MC101,DEV=0 &
```

If, instead of connecting a MC-101 to your setup, you're planning to connect a different USB Class Compliant instrument, then you need to replace all the instances of `MC101` in [this script](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh) with the Card Name of your instrument. To find the Card Name of your instrument, connect it to the Raspberry Pi and type `aplay -l`.

Alternatively, if you're not connecting any additional device to your setup besides the M8, then you can completely remove the following section from [this script](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh):

```
# Check if the Instrument with the Card Name "MC101" is connected to the Raspberry Pi

...

fi
```

Please note that you should not start the JACK server using `jackd -d alsa -d hw:M8 -r44100 -p512 &` (or a similar configuration) because this service is automatically started upon boot by [Patchbox OS](https://blokas.io/patchbox-os/docs/software-guides). You will mostly run into errors if you attempt to do this.

## Alsamixer Levels and Noise Suppression

Depending on the type and/or model of audio card you are using for this project, you may need to adjust the audio input and output levels.

To do that, open a terminal and type `alsamixer`. Then, using the arrows, adjust the output and input levels of your audio card.

While in `alsamixer`, you should also check for any undesired noises coming from the USB sound card or any other devices. You can play with the levels to suppress the noise and/or disable `Auto Gain Control` to hear how it impacts the noise.

As an example, I'm using the following audio configuration and levels:
```
Card M8: PCM Mute
Card USB Audio Device: Speaker 54<>54 (dB gain: -16); Mic Mute or 0; Capture 53 (dB gain: 12); Auto Gain Control Mute or Off
```

Exit `alsamixer` using escape and save your adjustments by typing `sudo alsactl store`.

## References

For more information, please visit [JACK Audio Connection Kit wiki](https://github.com/jackaudio/jackaudio.github.com/wiki). This [link](https://askubuntu.com/questions/1153655/making-connections-in-jack-on-the-command-line) is also very helpful.
