#!/usr/bin/env bash
read -p "Version (0.1.0-1): " ver
dpkg-deb --build . calla_$ver\_amd64.deb
