#!/bin/bash
#
# This script loads the required kernel module for playing a video file into the camera interface
#
# The module can be built from: https://github.com/umlaeute/v4l2loopback
#
# sudo apt-get install ffmpeg

CAMERA_DEVICE=""

function find_camera() {
        EXISTING_INTERFACES=$(ls /dev/video* 2>/dev/null)
        if [ -z "${EXISTING_INTERFACES}" ]
        then
                echo "No cameras found"
                exit -1
        fi
        CAMERA_DEVICE=$(echo "${EXISTING_INTERFACES}" | head -n 1)
        if [ ! -e "${CAMERA_DEVICE}" ]
        then
                echo "Could not open device ${CAMERA_DEVICE}" 
                exit -1
        fi
        echo "Camera ${CAMERA_DEVICE} selected"
}

ALSA_DEVICE=""

function find_snd() {
        # Get card and device numbers for alsa loopback device
        # 2nd loopback device is the fake mic
        while read -r line; do
                if [[ $line =~ card[[:space:]]([[:digit:]]*):[[:space:]]Loopback.*device[[:space:]]([[:digit:]]*) ]]
                then
                        card="${BASH_REMATCH[1]}"
                        device="${BASH_REMATCH[2]}"
                        echo $BASH_REMATCH
                        echo "card $card, device $device"
                        ALSA_DEVICE="hw:$card,$device"
                fi
        done <<< "$(aplay -l)"

        if [ -z $ALSA_DEVICE ]
        then
                echo "Could not find alsa loopback device, make sure to run 'sudo modprobe snd-aloop'"
                exit -1
        fi
        echo "Alsa Device ${ALSA_DEVICE} selected"
}

        
find_camera
find_snd
ffmpeg ${FFMPEG_OPTIONS} -stream_loop -1 -re -i /root/demo.mp4 -f v4l2 ${CAMERA_DEVICE} -map 0:1 -ar 16000 -f alsa ${ALSA_DEVICE}
