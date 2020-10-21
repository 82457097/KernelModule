#!/usr/bin/python

import socket

udpsocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sdata = b"hello"
saddr = ('192.168.127.50', 12345)
udpsocket.sendto(sdata, saddr)
