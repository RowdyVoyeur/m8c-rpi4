# M8C for Raspberry Pi 4 Model B

## Introduction

The [Dirtywave M8 Tracker](https://dirtywave.com/products/m8-tracker-model-02) is a portable sequencer and synthesizer, featuring 8 tracks of assignable instruments such as FM, waveform synthesis, virtual analog, sample playback, and MIDI output. It is powered by a [Teensy](https://www.pjrc.com/teensy/) micro-controller and inspired by the Gameboy tracker [Little Sound DJ](https://www.littlesounddj.com/lsd/index.php).

While Dirtywave makes new batches of units on a regular basis, M8 is often sold out due to the high demand of the unit. To fill this gap and and to allow users to freely test this wonderful tracker, [Timothy Lamb](https://github.com/trash80) was kind enough to make the [M8 Headless](https://github.com/Dirtywave/M8HeadlessFirmware) available to everyone.

Note that this project is for educational and testing purposes only. If you like the M8 and you gel with the tracker workflow, please support [Dirtywave](https://dirtywave.com/) by purchasing the actual unit. You can check its availability [here](https://dirtywave.com/products/m8-tracker-model-02). Meanwhile, you can also subscribe to Timothy Lamb's [Patreon](https://www.patreon.com/trash80).

This is a fork of [laamaa](https://github.com/laamaa)'s fantastic cross platform [M8 tracker headless client](https://github.com/laamaa/m8c) or M8C for short and includes some modifications based on [rasprague's fork](https://github.com/rasprague/m8c-piboy). The modifications are the following: Add two special button combinations for resetting the display and quitting the program before shutting down the Raspberry Pi; Add the option to disable the mouse cursor.

M8C is a client for [Dirtywave M8](https://dirtywave.com/) headless mode. The original [application](https://github.com/laamaa/m8c) should be cross-platform ready and can be built in Linux, Windows, Mac OS and Android. However, this specific fork has been tested only on Raspberry Pi 4 Model B.

The main objective of this fork is to run M8C on a Raspberry Pi 4 with the best performance possible. Which means a stable setup with a good resolution and acceptable refresh rate, low audio latency and no audio artifacts such as random clicks and pops. After testing different approaches, I've settled for [Blokas Patchbox OS](https://blokas.io/patchbox-os/) and [SDL2](https://wiki.libsdl.org/SDL2/Introduction).

Below, you'll find the instructions to install Patchbox OS, configure the system, install M8C and a [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module) to automatically launch M8C on boot. In the end, M8C should start automatically on boot, connect your audio and MIDI devices and shutdown after quitting M8C.

If you have a Dirtywave M8 or if you're using M8 Headless, feel free to visit [this website](https://sites.google.com/view/m8tracker/) I created with a bunch of shortcuts, tips and tricks for the M8. Additionally, if you have a Roland MC-101, which is part of this project, you may also visit [my other website](https://sites.google.com/view/rolandmc101) with tips and tricks for this groovebox.

## Acknowledgments

This project would not exist without [Timothy Lamb](https://github.com/trash80)'s phenomenal invention, the [Dirtywave M8 Tracker](https://dirtywave.com/products/m8-tracker-model-02). Thank you for developing this fantastic product and for allowing the community to test and play it with the M8 Headless!

The M8C is also an essential part of this puzzle. Thank you very much [laamaa](https://github.com/laamaa) for putting [this](https://github.com/laamaa/m8c) together and [rasprague](https://github.com/rasprague) for your great modifications!

And, finally, thank you to all the people at [M8 Discord server](https://discord.com/invite/WEavjFNYHh) for your support.

## Disclaimer

While this project may give you access to some sort of a handheld M8 with relatively low audio latency and reasonable stability, this should be regarded as a temporary device for testing or learning purposes.

From my experience, you may end up with audio latency (even if minor) and eventual random crashes (mostly due to alsa's instability). The user experience will feel crippled when compared with what you would get with the actual M8, and there is no customer support for this project.

The Teensy 4.1, while very robust, may get damaged when handled by inexperienced people (like me) and you may need to spend money buying more than one. Furthermore, you may need to put a lot of time onto this project and those hours have a cost. Which means that this project could be more expensive than buying the actual M8 unless you already have everything you need and you know very well what you are doing.

Please note that this project is not affiliated with Dirtywave and there is no guarantee or support from either the manufacturer or myself. You can build it at your own risk.

-------

# Project

## Problem

Putting together a device with a Raspberry Pi 4 with a screen, a Teensy board, a sound card, a game controller or keyboard, and a power bank or battery will always end up being a hot mess of cables.

This could be partially solved with a case, such as a PiBoy, or by 3D printing a custom case. However, this is a temporary device and I want to use most (if not all) of the parts in different audio projects. Thus, I opted to create something fun and easy to build and take apart.

## Solution

I started thinking about different solutions, but Lego immediately became the obvious choice. I would be lying if I said that no Lego parts were hurt in this project. Afterall, it's not easy to hold the boards without screws.

## Pictures

Picture of headless M8 Tracker running in Raspberry Pi 4 Model B with 1 GB of RAM:

<img src="https://raw.githubusercontent.com/RowdyVoyeur/m8c-rpi4/main/images/1.jpg" width="500">

Another picture of the setup with headphones for scale:

<img src="https://raw.githubusercontent.com/RowdyVoyeur/m8c-rpi4/main/images/2.jpg" width="500">

And, lastly, a picture showing the different gear that can be connected:

<img src="https://raw.githubusercontent.com/RowdyVoyeur/m8c-rpi4/main/images/3.jpg" width="500">

## Videos

Here's a quick demo video of this project (click on the image to watch the video):

[![Alt text](https://raw.githubusercontent.com/RowdyVoyeur/m8c-rpi4/main/images/4.jpg)](https://www.youtube.com/watch?v=DUUrMIigKtw)

And here's a video showing the unit's innards and how the Lego buttons work (click on the image to watch the video):

[![Alt text](https://raw.githubusercontent.com/RowdyVoyeur/m8c-rpi4/main/images/5.jpg)](https://www.youtube.com/watch?v=c4iNQlCQH8I)

-------

# Requirements

- A working [Raspberry Pi 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/). I tested a discontinued 1GB model and a 4GB model, so any Raspberry Pi 4 Model B should do.

- A screen such as a [Waveshare](https://www.waveshare.com/wiki/5inch_HDMI_LCD_(H)) or [equivalent](https://www.amazon.es/OSOYOO-Touchscreen-LCD-Monitor-TFT-Audioausgang-Anleitung/dp/B086JPTKYV). I tested a 5.0" and a 3.5" HDMI LCD. They both work, with obvious pros and cons each.

- A [TeenTeensy 4.1 board](https://www.pjrc.com/store/teensy41.html) with the latest [M8 Headless Firmware](https://github.com/Dirtywave/M8HeadlessFirmware) installed.

- A [USB cable with 5-Pin Micro-B plug](https://www.pjrc.com/store/cable_usb_micro_b.html) to connect the Teensy to the Raspberry Pi. Must be a power and data cable, otherwise the Pi will not find the Teensy.

- An audio interface. I got a cheap [USB sound card](https://www.aliexpress.com/item/1005004769417874.html) with a [HS-100B](https://datasheet.lcsc.com/lcsc/1912111437_Cmedia-HS-100B_C371351.pdf) chip. It's great because it handles 48K or 44.1KHz sampling rates and small buffer sizes. The only downside is the mono ADC, which means that I have stereo output, but only mono input. A [Pisound](https://blokas.io/pisound/) also works great, albeit substantially more expensive.

- A USB game controller, a standard keyboard or a small [macro keyboard](https://pt.aliexpress.com/item/1005005903228059.html). I'm using a Geeekpi set of controllers, but I wanted something really cheap so I could remorselessly take it apart.

- A power adapter for the Raspberry Pi, a power bank or something similar if you want a portable device. I'm using something like [this](https://github.com/rcdrones/UPSPACK_V3/blob/master/README_en.md) and a [LiPo battery](https://www.amazon.es/Seamuing-recargable-protectora-revestimiento-aislamiento/dp/B0953L98RK) because my power bank wasn't cutting it.

- Some additional USB cables, preferably with ferrite core to filter out undesirable noise.

- An ethernet cable because we will disconnect Wi-Fi to save battery and, hopefully, improve performance.

- Lastly, if you want to put together something similar to what I've done, then you'll need lots of Lego. Preferably Lego Technics to keep everything cool and well ventilated. 

-------

# Installation

## Install and Configure Patchbox OS

1. Download and install [balenaEtcher](https://www.balena.io/etcher/).

2. Download and unzip [Patchbox OS 2024-04-04 (Bookworm ARM64 Debian)](https://dl.blokas.io/patchbox-os/2024-04-04-Patchbox.zip) or [Patchbox OS 2022-05-17 (Bullseye Debian)](https://dl.blokas.io/patchbox-os/image_2022-05-17-Patchbox.zip).

3. Insert the SD card to your computer's SD card reader and launch [balenaEtcher](https://etcher.balena.io/).

4. Click `Flash from File` and select `2024-04-04-Patchbox.img` or `2022-05-17-Patchbox.img`.

5. Click `Select Target`, choose your SD card and click `Flash`.

6. After flashing, safely remove the SD card, insert it into your Raspberry Pi and power it on.

7. Connect your computer to the same Network as the Raspberry Pi (using an ethernet cable to connect the RPi to the network), open a Terminal window (or equivalent if not using macOS) and paste the following after boot is complete (default password: `blokaslabs`). All the steps in this tutorial are done via SSH:
```
ssh-keygen -R patchbox.local
ssh patch@patchbox.local
```

8. Follow the Setup Wizard instructions of the `Patchbox Configuration Utility`:

- If prompted, start by updating Patchbox OS;

- Then, for security reasons, change the default password;

- Follow these [instructions](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md#patchbox-os-setup-wizard) to configure the audio settings;

- Choose the boot environment `Console Autologin`;

- When prompted, configure Wi-Fi;

- Select `None: Default Patchbox OS Environment` to disable modules;

- Once the Setup Wizard is finished, type `patchbox` to enter the `Patchbox Configuration Utility` and stop Bluetooth, then disconnect Wi-Fi from default network and disable WiFi hotspot;

- **Only if you're using Patchbox OS 2024-04-04 (Bookworm ARM64 Debian) with a Raspberry Pi 4 Model B:** Still in the `Patchbox Configuration Utility`, go to `kernel` and select `install-rt switch te current kernel to realtime one` to enable the RT kernel;

- Reboot with ```sudo reboot```.

9. Open the `config.txt` file to edit the display settings, disable Bluetooth and WiFi and improve boot time:
```
sudo nano /boot/config.txt
```

10. You may need to adjust the display settings to achieve a suitable resolution for M8C (more information [here](https://www.raspberrypi.com/documentation/computers/config_txt.html), [here](https://pimylifeup.com/raspberry-pi-screen-resolution) and [here](https://www.scribd.com/document/519276699/raspberry-pi-4-HDMI)).

- For the 3.5" HDMI LCD, edit the following lines, under the HDMI settings (may not work in Bookworm):
```
hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=2
hdmi_cvt=480p 60 6 0 0 0
```

- For a [5.0" Waveshare HDMI LCD](https://www.waveshare.com/wiki/5inch_HDMI_LCD_(H)), edit the following lines, under the HDMI settings (may not work in Bookworm):
```
#hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=87
hdmi_cvt 800 480 60 6 0 0 0
```

11. If you have black borders around your display or if you cannot see the whole display, you may need to adjust `overscan`. In my case, I need to add the following so the left side of the display doesn’t go under the screen cover/protection (may not work in Bookworm):
```
overscan_left=16
```

12. Disable the on-board or internal (Broadcom) sound card, just add the following under `# Enable audio (loads snd_bcm2835)` ([source](https://raspberrypi.stackexchange.com/questions/80072/how-can-i-use-an-external-usb-sound-card-and-set-it-as-default)):
```
dtparam=audio=off
```

13. Disable HDMI audio, under `# Enable DRM VC4 V3D driver` ([source](https://forums.raspberrypi.com/viewtopic.php?t=324935#:~:text=The%20analogue%20audio%20output%20can,Engineer%20at%20Raspberry%20Pi%20Trading.)):
```
dtoverlay=vc4-kms-v3d,noaudio
```

14. Disable Wi-Fi and Bluetooth by adding the following under the first `[all]` ([source](https://www.animmouse.com/p/how-to-disable-wifi-and-bluetooth-on-raspberry-pi/)). To enable these options back, just comment each line. Note that you’ll need an ethernet cable from here on:
```
dtoverlay=disable-bt
dtoverlay=disable-wifi
```

15. Exit with `ctrl + x`, save and reboot the Raspberry Pi.

16. Type ```sudo raspi-config``` to enter `raspi-config`. Then, disable `Splash Screen` and `Wait for Network on Boot`, under `System Options` and `Network at Boot` (may not work in Bookworm).

17. Still in `raspi-config`, go to `Localisation Options`, then `Locale`. Select `en_US.UTF-8` only, deselecting other languages (use the `spacebar` to select/deselect). Complete all the `Localisation Options`, inlcuding `Timezone` and `Wi-Fi Country`. Exit `raspi-config` and reboot.

18. Login again and finish setting the locale:
```
sudo update-locale LC_ALL="en_US.UTF-8"
sudo update-locale LANGUAGE="en_US"
sudo reboot
```

19. Login again and check that your Raspberry Pi OS locale is properly set by typing the command ```locale``` and making sure it returns the following:
```
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
```

20. Disable Patchbox related services that are not being used. More information [here](https://blokas.io/patchbox-os/docs/troubleshooting):

- Opt-out of [statistics program](https://blokas.io/patchbox-os/docs/telemetry), and disable `Wi-Fi Hotspot`:
  ```
  sudo systemctl disable --now blokas-telemetry.target
  sudo systemctl disable wifi-hotspot.service
  ```
  
- If you're not using [TouchOSC2MIDI](https://github.com/velolala/touchosc2midi), disable `touchosc2midi`:
  ```
  sudo systemctl disable touchosc2midi
  ```

- If you're not using [Pisound](https://blokas.io/pisound/), disable `pisound-ctl`, `pisound-btn`.
  ```
  sudo systemctl disable pisound-ctl
  sudo systemctl disable pisound-btn
  ```
      
21. Check if PulseAudio is running by typing `pactl list` in terminal. If PulseAudio is not necessary for your project, you can save some resources and avoid conflicts by permanently disabling it:
```
systemctl --user stop pulseaudio.socket
systemctl --user stop pulseaudio.service
systemctl --user disable pulseaudio.socket
systemctl --user disable pulseaudio.service
systemctl --user mask pulseaudio.socket
systemctl --user mask pulseaudio.service
```

-----------

## Prepare to Install M8C

22. Login again, update, install required packages and install `SLD2` ([source](https://wiki.libsdl.org/SDL2/Installation#linuxunix)):
```
sudo apt update && sudo apt install -y git gcc make libsdl2-2.0-0 libsdl2-dev
sudo reboot
```

23. Install other package needed to compile and install M8C:
```
sudo apt install -y autotools-dev autoconf libtool
```

24. Download the source code for `libserialport`:
```
cd
git clone https://github.com/sigrokproject/libserialport.git
```

25. After cloning, compile and install:
```
cd libserialport
./autogen.sh
./configure
make
sudo make install
```

26. A couple more steps:
```
sudo ln -s /usr/local/lib/libserialport.so.0.1.0 /usr/lib/libserialport.so.0.1.0
sudo ln -s /usr/local/lib/libserialport.so.0 /usr/lib/libserialport.so.0
```

27. And finally, run to finalise the packages installation and to ensure the library is found when building M8C:
```
sudo ldconfig
```

-----------

## Install and Configure M8C

28. At this stage, you can reboot before installing M8C:
```
cd
git clone https://github.com/RowdyVoyeur/m8c-rpi4.git
```

29. Followed by the commands below, once it’s cloned:
```
cd m8c-rpi4
make
sudo make install
```

30. Lastly, make shell scripts executable by everyone:
```
sudo chmod +x m8c*.sh
```

31. To generate the config files in `.local/share/m8c` you need to run M8C once. Connect the [Teensy 4.1](https://www.pjrc.com/store/teensy41.html) with the installed [M8 Headless Firmware](https://github.com/Dirtywave/M8HeadlessFirmware) to the Raspberry Pi 4 using a USB data cable. Wait 10 seconds to ensure it is properly connected and run the following commands (use Ctrl+C to quit M8C):
```
cd m8c-rpi4
./m8c
```

32. Find if `config.ini` has been successfully generated (if config.ini isn't listed in this folder, repeat the step above):

- Enter the following to go to the folder where `config.ini` should be:
```
cd /home/patch/.local/share/m8c/
```

- Then, list the folder contents to see if `config.ini` is there:
```
ls
```

33. Edit the `config.ini` file, so the `[graphics]` and `[gamepad]` sections look like [this](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/config.ini.sample). Check if `fullscreen` and `disable_cursor` are set to `true`.
```
sudo nano config.ini
```

34. Then, if you're using a game controller, type the following to point the M8C to the `gamecontrollerdb.txt`, so it finds your game controller mapping:
```
cd ~/.local/share/m8c
ln -s ~/m8c-rpi4/gamecontrollerdb.txt .
```

-----------

## Game Controller, Keyboard or Macro Keyboard Configuration

35. On startup, M8C tries to load a SDL game controller database named gamecontrollerdb.txt from the same directory as the config file. Therefore, you need to check whether `gamecontrollerdb.txt` is inside `.local/share/m8c/`. Assuming the `gamecontrollerdb.txt` is in the right place, then you need to ensure that your specific game controller mapping is listed in this file. Just go to `~/m8c-rpi4`, edit `gamecontrollerdb.txt` and do one of the following:

- Copy the full updated database from [here](https://github.com/gabomdq/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt) and paste it onto `gamecontrollerdb.txt`. If your game controller is listed, then M8C should automagically recognize it;

- If this does not work, then download [SDL2 Gamepad Tool](https://generalarcade.com/gamepadtool/) and follow the instructions to get your game controller mapping. Once you have the mapping, paste it under the `#Custom` line of `gamecontrollerdb.txt`;

- You may need to edit the `[gamepad]` section of the `config.ini` file found in `.local/share/m8c` to match the configuration of your game controller. You can find more information about the required values [here](https://wiki.libsdl.org/SDL2/SDL_GameControllerButton). If you are using the same game controller as me, then the `[gamepad]` section should remain like [this](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/config.ini.sample).

36. If you're using a standard keyboard, then you just need to connect it to the Raspberry Pi.

- The following keys should work straight away:

  | Key(s) | Command |
  | --- | --- |
  | Up Arrow | [UP] |
  | Down Arrow | [DOWN] |
  | Left Arrow | [LEFT] |
  | Right Arrow | [RIGHT] |
  | z / Left Shift | [SHIFT] |
  | x / Space | [START] |
  | a / Left Alt | [OPTION] |
  | s / Left Ctrl | [EDIT] |
  | Alt + F4 | Quit M8C |
  | Alt + Enter | Toggle Full Screen / Windowed |
  | r | [SELECT]+[START]+[OPTION]+[EDIT] / Reset Display |
  | Delete | [OPTION] + [EDIT] / Delete row |
  | Esc | Toggle Keyjazz On / Off |

- You may want to edit the `[keyboard]` section of the `config.ini` file found in `.local/share/m8c` to customise your keys. In this case, use the Decimal Values listed in the first column of this [table](https://github.com/libsdl-org/sdlwiki/blob/main/SDL2/SDLScancodeLookup.mediawiki).

37. If you're using a macro keyboard such as [this](https://pt.aliexpress.com/item/1005005903228059.html), then it's easier to configure its keys using the available [software](https://sayodevice.com/), instead of editing the `config.ini` file. You can even change the button behaviour to FN, so you can create layers to access additional key combos.

-----------

## Audio Configuration

38. You may need to customise [this script](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh) to your needs, as described [here](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md#m8c-bash-script). If you have audio related problems, you may need to reconfigure the audio settings in Patchbox OS `Setup Wizard`, as listed [here](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md#patchbox-os-setup-wizard).

39. If the input is too hot or distorted, adjust the audio levels by opening Terminal and typing `alsamixer`. Then, use the arrows to adjust the output and input levels of your audio card. Exit `alsamixer` using Escape and save your adjustments by typing `sudo alsactl store`. Find more information [here](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md#alsamixer-levels-and-noise-suppression).

-----------

## Install Patchbox Module

40. To automatically start M8C on system boot without configuring `systemd` or `crontab`, you should install the [m8c-rpi4-module](https://github.com/RowdyVoyeur/m8c-rpi4-module) with the following command:
 
```
patchbox module install https://github.com/RowdyVoyeur/m8c-rpi4-module
```

41. Activate the module by running the command below or, alternatively, type `patchbox` in Terminal, go to modules menu and select `m8c-rpi4-module`:
```
patchbox module activate m8c-rpi4-module
```

42. The module should start between 5 and 10 seconds after activation. If it does not start, confirm that M8C is installed at `home/patch/m8c-rpi4` and the script `m8c.sh` is executable by everyone. If you are on Patchbox OS 2022-05-17 and see any errors related to amidiauto, please follow these [instructions](https://github.com/RowdyVoyeur/m8c-rpi4-module?tab=readme-ov-file#patchbox-os-2022-05-17-bullseye-debian).

-----------

## MIDI Configuration

43. [amidiauto](https://blokas.io/patchbox-os/docs/amidiauto/) is a background process of Patchbox OS 2022-05-17, which takes care of setting up the MIDI routings automatically. However, in Patchbox OS 2024-04-04, amidiauto was deprecated in favour of [amidiminder](https://github.com/mzero/amidiminder), which performs the same functions, but better.

44. Here's how to configure MIDI if you're using **Patchbox OS 2024-04-04** and [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module):

- After installing the [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module),you can customise your MIDI connections by editing the file [amidiminder.rules](https://github.com/RowdyVoyeur/m8c-rpi4-module/blob/main/amidiminder.rules). Just follow these [instructions](https://github.com/RowdyVoyeur/m8c-rpi4-module/tree/main#patchbox-os-2024-04-04-bookworm-arm64-debian);

- This setup works exclusively with this [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module). So, if you switch modules, these settings should not have any effect;

- Alternatively, you can make these settings permanent for your system. Amidiminder utility (more information [here](https://github.com/mzero/amidiminder) and [here](https://community.blokas.io/t/amidiminder-utility/2243/1)) reads its MIDI rules from the file `/etc/amidiminder.rules`.
  
  - Therefore, you need to edit this file to add your own MIDI rules:
    ```
    sudo nano /etc/amidiminder.rules
    ```

  - After adding your rules, you need to check if the rules are legal with the following command:
    ```
    amidiminder -C -f /etc/amidiminder.rules
    ```

  - And, lastly, you need to restart the service:
    ```
    sudo systemctl restart amidiminder
    ```
    
45. Here's how to configure MIDI if you're using **Patchbox OS 2022-05-17** and [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module):

- You can customise your MIDI connections by editing the file [amidiauto.conf](https://github.com/RowdyVoyeur/m8c-rpi4-module/blob/main/amidiauto.conf). Just follow these [instructions](https://github.com/RowdyVoyeur/m8c-rpi4-module/tree/main#patchbox-os-2022-05-17-bullseye-debian);

- This setup works exclusively with this [Patchbox module](https://github.com/RowdyVoyeur/m8c-rpi4-module). So, if you switch modules, these settings won't have any effect;

- Alternatively, you can make these settings permanent for your system by editing the Patchbox OS `amidiauto.conf`. To create a `amidiauto.conf` that makes the MIDI settings permanent to your system (instead of using the Patchbox module), you should follow the steps below:
  
  - Visit [this page](https://community.blokas.io/t/midi-connection-manager/567/8) to understand how things work.

  - List all the connected MIDI devices to find their names with the following command:
  ```
  aconnect -l
  ```

  - Create your own version of [this file](https://github.com/RowdyVoyeur/m8c-rpi4-module/blob/main/amidiauto.conf) or edit the Patchbox OS `amidiauto.conf` with the following command:
  ```
  sudo nano /etc/amidiauto.conf
  ```

46. **Optional:** You can install these [MIDI tools](https://github.com/RowdyVoyeur/midi-tools) to control parameters of M8C and Patchbox OS with an [external MIDI device](https://github.com/RowdyVoyeur/midi-tools/tree/main/nanoKONTROL), including [switching audio routings on the fly](https://github.com/RowdyVoyeur/midi-tools/tree/main/nanoKONTROL#audio-routing), adjusting some `Alsamixer` volume levels and several other things.

-----------

## Final Checks

47. The [M8C script](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh), together with the [m8c-rpi4-module](https://github.com/RowdyVoyeur/m8c-rpi4-module) should now be able to autostart the M8C on system boot, display the M8 graphics on the screen, connect the audio ports so you can hear what you're playing and sample any external instruments, connect the configured MIDI devices and shutdown the Raspberry Pi upon quitting the M8C with the button combination.

48. If you're using a game controller, you should be able to use the following button combinations:

- Quit M8C and automatically shutdown Raspberry Pi: `[SELECT] + [OPTION] + [DOWN]`

- Reset display in case of graphic glitches: `[SELECT] + [OPTION] + [UP]`

49. If the M8C starts on boot, you can see and hear the M8 audio and record onto it, sync your connected MIDI devices and shutdown with the button combination, then you're good to go.

50. Well done! Grab a cup of coffee, read the M8 [User Manual](https://dirtywave.com/pages/resources-downloads) and start saving for the [real deal](https://dirtywave.com/products/m8-tracker-model-02) ;)
