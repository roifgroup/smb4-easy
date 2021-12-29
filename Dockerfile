FROM ubuntu
ARG SMBVER=4.15.3
RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" wget && apt-get upgrade -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*
COPY ./requirements.sh /tmp/requirements.sh
WORKDIR /tmp
RUN chmod +x /tmp/requirements.sh && /tmp/requirements.sh && wget https://download.samba.org/pub/samba/stable/samba-$SMBVER.tar.gz && tar -xvf samba-$SMBVER.tar.gz && cd samba-$SMBVER && \
./configure --without-ad-dc --disable-cups && make -j `nproc` && make install && cd /tmp && rm -rf samba-$SMBVER.tar.gz samba-$SMBVER


FROM ubuntu
RUN apt-get update && apt-get upgrade -y && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \ 
apt install -y libbsd0 libpopt0 libldap-2.4-2 libcap2 libicu66 libunwind8 libjansson4 libtracker-sparql-2.0-0 && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*

COPY --from=0 /usr/local/samba /usr/local/samba

EXPOSE 137/udp 138/udp 139 445

COPY ./smb.conf /usr/local/samba/etc/smb.conf
COPY ./smb.sh /smb.sh
COPY ./set_user.sh /set_user.sh
RUN mkdir /var/log/samba && chmod +x /smb.sh /set_user.sh
CMD /smb.sh