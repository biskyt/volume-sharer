FROM dperson/samba
MAINTAINER biskyt

VOLUME ["/etc/samba"]


#Based on this, we now install docker inside this image
#this means we have to install cURL and docker
RUN apk --no-cache --no-progress upgrade \
    && apk --no-cache --no-progress add docker

#This is needed to ensure smbd is running as root to access
#all the files in the volumes directory
ENV USERID=0 GROUPID=0

#Copy the volume-sharer file to bin
COPY volume-sharer.sh /usr/bin/volume-sharer.sh
RUN chmod a+rx /usr/bin/volume-sharer.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/volume-sharer.sh"]
