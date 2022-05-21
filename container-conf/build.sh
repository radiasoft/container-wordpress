#!/bin/bash
build_image_base=wordpress:4.9.5-php7.2-apache
build_is_public=1
build_simply=1
build_docker_user=$build_run_user
build_dockerfile_aux='ENTRYPOINT []'

build_as_root() {
    cd "$build_guest_conf"
    build_create_run_user
    # hardwires the ports, and hardwired include
    install -m 444 /dev/null /etc/apache2/ports.conf
    chown -R "$build_run_user:$build_run_user" /var/www/html
    perl -pi -e 's/(?<=^ServerTokens).*/ Minimal/' /etc/apache2/conf-enabled/security.conf
    # StartServers, MaxConnectionsPerChild, etc. set in 000-default.conf.
    rm -f /etc/apache2/mods-enabled/mpm_prefork.conf
    # This create two logs
    rm -f /etc/apache2/conf-enabled/other-vhosts-access-log.conf
}
