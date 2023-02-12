#!/bin/bash
SMBLATEST=$(curl -s https://download.samba.org/pub/samba/stable/ | grep -o 'samba-[[:digit:]]\{1,\}.[[:digit:]]\{1,\}.[[:digit:]]\{1,\}.tar.gz' \
  | grep -oh '[[:digit:]]\{1,\}.[[:digit:]]\{1,\}.[[:digit:]]\{1,\}' | tail -n 1)
docker build -t smb:${SMBLATEST} -t smb:latest . --build-arg SMBVER=${SMBLATEST}
