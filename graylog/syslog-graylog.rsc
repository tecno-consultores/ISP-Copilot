/system logging action add name=action1 remote=192.168.1.1 remote-log-format=syslog remote-port=1514 syslog-facility=syslog target=remote
/system logging add action=action1 prefix=critical topics=critical
/system logging add action=action1 prefix=error topics=error
/system logging add action=action1 prefix=info topics=info
/system logging add action=action1 prefix=warning topics=warning
