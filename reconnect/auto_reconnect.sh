#!/bin/bash
### BEGIN INIT INFO
# Provides:          auto_reconnect.sh
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO

#1) 将脚本复制到 /etc/init.d目录下。

#2) 设置脚本文件的权限
#	$ sudo chmod 755 /etc/init.d/auto_reconnect.sh

#3) 执行如下命令将脚本放到启动脚本中去：
#	$ cd /etc/init.d
#	$ sudo update-rc.d auto_reconnect.sh defaults 95

getway() {
	SonyGateWay=`ifconfig tun0 | grep "inet " | awk '{print $2}' | awk -F: '{print $2}'`

	if [ -n $SonyGateWay ]; then
		sudo route add -net 10.128.0.0/9 gw $SonyGateWay
		sudo route del -net 0.0.0.0/1 gw $SonyGateWay
		sudo route del -net 128.0.0.0/1 gw $SonyGateWay
	fi	
}

while true
do
	SonyGateWay=`ifconfig | awk 'NR==20{print $1}'`
	if [ "$SonyGateWay" = "tun0" ]; then
		ping -c 2 192.168.127.27 >/dev/null
		if [ $? -eq 0 ]; then
			sleep 10
			continue
		else
			getway
		fi
	else
		sleep 8
	fi
done

