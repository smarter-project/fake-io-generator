# fake-io-generator
SMARTER Example to test demo without the need to have physical cameras or microphones

Using this workload will allow pulseaudio to pickup a fake microphone device which is playing the audio output of `demo.mp4`

A pulseaudio client can access the audio generated by setting the env `PULSE_SOURCE=alsa_input.platform-snd_aloop.0.analog-stereo`
