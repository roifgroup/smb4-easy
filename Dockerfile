FROM ubuntu:22.04
ARG SMBVER=4.15.3
RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" wget && apt-get upgrade -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*
COPY ./requirements.sh /tmp/requirements.sh
WORKDIR /tmp
RUN chmod +x /tmp/requirements.sh && /tmp/requirements.sh && wget https://download.samba.org/pub/samba/stable/samba-$SMBVER.tar.gz && tar -xvf samba-$SMBVER.tar.gz && cd samba-$SMBVER && \
./configure --without-ad-dc --disable-cups && make -j `nproc` && make install && cd /tmp && rm -rf samba-$SMBVER.tar.gz samba-$SMBVER
COPY ./smb.conf /usr/local/samba/etc/smb.conf


FROM ubuntu:22.04
RUN apt-get update && apt-get upgrade -y && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \ 
apt install -y libldap-common libldap-2.5-0 libicu70 libbsd0 libpopt0 libcap2 libunwind8 libjansson4 && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*

COPY --from=0 /usr/local/samba /usr/local/samba

EXPOSE 137/udp 138/udp 139 445

COPY ./smb.sh ./set_user.sh /
RUN mkdir /var/log/samba && chmod +x /smb.sh /set_user.sh
CMD /smb.sh
