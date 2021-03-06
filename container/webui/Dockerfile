#!BuildTag: openqa_webui
FROM opensuse/leap:15.2
LABEL maintainer Jan Sedlak <jsedlak@redhat.com>, Josef Skladanka <jskladan@redhat.com>, wnereiz <wnereiz@eienteiland.org>, Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="0.3"

RUN zypper ar -p 95 -f http://download.opensuse.org/repositories/devel:openQA/openSUSE_Leap_15.2 devel_openQA && \
    zypper ar -p 90 -f http://download.opensuse.org/repositories/devel:openQA:Leap:15.2/openSUSE_Leap_15.2 devel_openQA_Leap && \
    zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive in ca-certificates-mozilla curl && \
    zypper --non-interactive in --force-resolution openQA-local-db apache2 hostname which w3m

# setup apache
RUN gensslcert && \
    a2enmod headers && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod proxy_wstunnel && \
    a2enmod ssl && \
    a2enmod rewrite && \
    a2enflag SSL
ADD openqa-ssl.conf /etc/apache2/vhosts.d/openqa-ssl.conf
ADD openqa.conf /etc/apache2/vhosts.d/openqa.conf
ADD run_openqa.sh /root/

# set-up shared data and configuration
RUN rm -rf /etc/openqa/openqa.ini /etc/openqa/client.conf \
      /etc/openqa/database.ini \
      /var/lib/openqa/share/factory /var/lib/openqa/share/tests \
      /var/lib/openqa/testresults && \
    chmod +x /root/run_openqa.sh && \
    mkdir -p /var/lib/openqa/pool && \
    ln -s /data/conf/openqa.ini /etc/openqa/openqa.ini && \
    ln -s /data/conf/database.ini /etc/openqa/database.ini && \
    ln -s /data/conf/client.conf /etc/openqa/client.conf && \
    ln -s /data/factory /var/lib/openqa/share/factory && \
    ln -s /data/tests /var/lib/openqa/share/tests && \
    ln -s /data/testresults /var/lib/openqa/testresults && \
    chown -R geekotest /usr/share/openqa /var/lib/openqa /var/log/openqa && \
    chmod ug+rw /usr/share/openqa /var/lib/openqa /var/log/openqa && \
    find /usr/share/openqa /var/lib/openqa /var/log/openqa -type d -exec chmod ug+x {} \;

EXPOSE 80 443 9526 9527 9528 9529
CMD ["/root/run_openqa.sh"]
