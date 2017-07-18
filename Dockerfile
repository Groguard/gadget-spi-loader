# ALPINE LINUX ARM WOOO!
FROM armhf/alpine

# WORKDIR
WORKDIR /app

# ADD SCRIPT
ADD spiselect.sh /app

# Install tools needed to download and build the CHIP_IO library from source.
RUN apk update && apk add make && apk add gcc && apk add g++ && \
    apk add flex && apk add bison && apk add git && \
        # Download source code for device tree compiler
        git clone https://github.com/NextThingCo/dtc.git && \
        # Build and install the device tree compiler
        cd dtc && make && make install PREFIX=/usr && \
        # Remove the device tree compiler source code now that we've built it
        cd .. && rm dtc -rf && \
        # Download NTC's chip overlay code
        git clone https://github.com/NextThingCo/CHIP-dt-overlays.git && \
        cd CHIP-dt-overlays && make && \
        # Make directories for the dtbo and copy over
        mkdir -p /lib/firmware/nextthingco/chip/ && \
        mkdir -p /lib/firmware/nextthingco/chip/early/ && \
        cp samples/*.dtbo /lib/firmware/nextthingco/chip/ && \
        cp firmware/early/*.dtbo /lib/firmware/nextthingco/chip/early/ && \
        cd ../ && rm -rf CHIP-dt-overlays && \
        # Remove build tools, which are no longer needed after installation
        apk del git && apk del make && apk del gcc && apk del g++ && apk del flex && apk del bison

CMD ["/bin/sh", "spiselect.sh"]

