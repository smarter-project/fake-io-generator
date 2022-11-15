# smarter-fake-io-generator

This chart provides an fake video and microphone for Smarter Edge.

## Functionality
- FFMpeg is used in a container to stream video and audio into fake linux devices, which can be captured by the workloads in the SMARTER edge demo.

- The workload attempts to find an open video device on the host, as well as a loopback sound device.

- Pulseaudio must be running on the machine, else if this workload is running, pulseaudio will not be able to automatically pickup the loopback audio device.

## Chart values

### Configuration

* pulseaudio
  How to access pulseaudio
  * host
    defaults smarter-pulseaudio

## Usage

```
helm install smarter-fake-io-generator chart
```

