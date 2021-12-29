ionice -c 3 /usr/local/samba/sbin/nmbd -D
exec ionice -c 3 /usr/local/samba/sbin/smbd -F --configfile=/usr/local/samba/etc/smb.conf </dev/null
