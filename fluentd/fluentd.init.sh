#!/sbin/runscript
# Copyright 2008-2011 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

FLUENTD_EXEC=${FLUENTD_EXEC:-/usr/local/bin/fluentd}
FLUENTD_PID=${FLUENTD_PID:-/run/fluent/fluentd.pid}
FLUENTD_CONF=${FLUENTD_CONF:-/etc/fluent/fluent.conf}
FLUENTD_LOG=${FLUENTD_LOG:-/var/log/fluent/fluentd.log}
FLUENTD_USER=${FLUENTD_USER:-fluent}
FLUENTD_GROUP=${FLUENTD_GROUP:-fluent}

command=${FLUENTD_EXEC}
command_args="--daemon ${FLUENTD_PID} --config ${FLUENTD_CONF} --log ${FLUENTD_LOG} ${FLUENTD_OPTS}"
extra_started_commands="reload flush"
pidfile=${FLUENTD_PID}
start_stop_daemon_args="--user ${FLUENTD_USER}:${FLUENTD_GROUP}"

depend() {
	use net
}

start_pre() {
	[ "$(dirname ${FLUENTD_PID})" != "/var/run" ] && checkpath -d -m 0755 -o ${FLUENTD_USER}:${FLUENTD_GROUP} -q $(dirname ${FLUENTD_PID})
	eend $?
}

reload() {
	ebegin "Reloading ${SVCNAME}"
	start-stop-daemon --signal HUP --pidfile $pidfile
	eend $?
}

flush() {
	ebegin "Flushing ${SVCNAME}"
	start-stop-daemon --signal USR1 --pidfile $pidfile
	eend $?
}
