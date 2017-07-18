#!/bin/sh

mount -t configfs none /sys/kernel/config
mkdir -p /sys/kernel/config/device-tree/overlays/spi
echo "moving sample-spi-chippro.dtbo to /sys/kernel/config/device-tree/overlays/spi"
cat /lib/firmware/nextthingco/chip/sample-spi-chippro.dtbo > /sys/kernel/config/device-tree/overlays/spi/dtbo
