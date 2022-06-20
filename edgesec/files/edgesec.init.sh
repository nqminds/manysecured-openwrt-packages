#!/bin/sh /etc/rc.common

START=95
STOP=5

# when using procd, the start() command
# should run the foreground (aka NOT DAEMON)
USE_PROCD=1
PROG=/usr/bin/edgesec
CONFIG_FILE=/etc/edgesec/config.ini

start_service() {
    procd_open_instance [instance_name]
    procd_set_param command "$PROG" -c "$CONFIG_FILE" -ddd

    # automatically reload EDGESec if the config file changes
    procd_set_param file "$CONFIG_FILE"

    # we don't use a custom EDGESec logdir
    # instead, redirect stdout/stderr to default OpenWRT logd
    # use `logread -e edgesec` to view logs
    procd_set_param stdout 1
    procd_set_param stderr 1

    procd_set_param pidfile /var/run/edgesec.pid

    # respawn automatically if something died, be careful if you have an alternative process supervisor
    # if process dies sooner than respawn_threshold, it is considered crashed and after 5 retries the service is stopped
    procd_set_param respawn ${respawn_threshold:-3600} ${respawn_timeout:-5} ${respawn_retry:-5}
}

# According to procd docs, the default `reload` action results in `procd`
# comparing states, and only reloading if the state has changed.
# (where state is stuff like if the config file has changed)
# Currently, we may need to manually restart EDGESec, e.g. if WiFi interfaces
# change, so by manually defining `reload_service`, procd will always restart
# edgesec when running `reload`
reload_service() {
    # copied from https://openwrt.org/docs/guide-developer/procd-init-scripts#forcing_service_restart

    # TODO: replace with procd_send_signal service_name [instance_name] [signal]
    # when https://github.com/nqminds/EDGESec/issues/166 is fixed
    stop
    start
}
