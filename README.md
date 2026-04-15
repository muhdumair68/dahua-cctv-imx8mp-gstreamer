# Dahua CCTV Camera Integration on NXP i.MX8MP (ARM64 Linux)

## Overview
Live video streaming from a Dahua IP camera to a custom 
Falcon S1 Lite ARM64 board (NXP i.MX8MP) using GStreamer 
and RTSP protocol on Linux.

## Board & Environment
| Item | Detail |
|------|--------|
| Board | Falcon S1 Lite (Custom ARM64) |
| Processor | NXP i.MX8MP |
| OS | Linux (Ubuntu) |
| GStreamer | 1.22.5 |
| Camera | Dahua CCTV |
| RTSP Port | 554 |

## Why GStreamer?
GStreamer is a pipeline-based multimedia framework 
perfect for embedded Linux. It supports the NXP VPU 
hardware decoder natively, offloading H264 decoding 
from the CPU to dedicated hardware.

## Why RTSP?
RTSP is the standard protocol used by IP cameras like 
Dahua to stream live video over a network. It is low 
latency and works plug-and-play with GStreamer.

## Working Pipeline
```bash
export DISPLAY=:0 && gst-launch-1.0 \
  rtspsrc location="rtsp://admin:password@192.168.0.220:554
  /cam/realmonitor?channel=1&subtype=0" \
  protocols=tcp latency=100 \
  ! rtph264depay ! h264parse ! vpudec ! videoconvert ! xvimagesink
```

## Quick Start
```bash
git clone https://github.com/yourusername/dahua-cctv-imx8mp-gstreamer
cd dahua-cctv-imx8mp-gstreamer
chmod +x run_dahuacctv.sh
./run_dahuacctv.sh
```

## Troubleshooting
| Error | Fix |
|-------|-----|
| Could not open display | export DISPLAY=:0 |
| No element avdec_h264 | Use vpudec instead |
| Failed to connect | ping 192.168.0.220 |

## License
MIT
