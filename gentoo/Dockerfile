FROM gentoo/portage
FROM gentoo/stage3-amd64

COPY --from=gentoo/portage /usr/portage /usr/portage

COPY portage /etc/portage

RUN emerge -NDuvt sci-physics/root \
 && rm -rf /tmp/* /usr/portage /var/tmp/portage

CMD /bin/bash -l
