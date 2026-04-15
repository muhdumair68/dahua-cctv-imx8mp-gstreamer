#!/bin/bash
export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

RTSP_URL="rtsp://admin:adminelliance1234@192.168.0.133:554/cam/realmonitor?channel=1&subtype=0"

# Using IMX VPU hardware decoder - best for i.MX8MP
gst-launch-1.0 \
  rtspsrc location="$RTSP_URL" protocols=tcp latency=100 \
  ! rtph264depay ! h264parse ! vpudec ! videoconvert ! xvimagesink
