#!/bin/sh /etc/rc.common

# start ssh-legion whenever
START=95
STOP=5

# when using procd, the start() command
# should run the foreground (aka NOT DAEMON)
USE_PROCD=1
PROG=/usr/bin/ssh-legion

start_service() {
    procd_open_instance [instance_name]
    procd_set_param command "$PROG"

    # we don't use a custom ssh-legion logdir
    # instead, redirect stdout/stderr to default OpenWRT logd
    # use `logread -e ssh-legion` to view logs
    procd_set_param stdout 1
    procd_set_param stderr 1

    # respawn automatically if something died, be careful if you have an alternative process supervisor
    # we wait 30 seconds before restarting the ssh-legion
    # we'll continiously restart the app until the end of time, since respawn_retry=0
    procd_set_param respawn ${respawn_threshold:-3600} ${respawn_timeout:-30} ${respawn_retry:-0}
}

# According to procd docs, the default `reload` action results in `procd`
# comparing states, and only reloading if the state has changed.
# (where state is stuff like if the config file has changed)
reload_service() {
    # copied from https://openwrt.org/docs/guide-developer/procd-init-scripts#forcing_service_restart
    stop
    start
}