obj-m += hello-1.o
obj-m += hello-2.o
obj-m += hello-3.o
obj-m += udpFilter.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) clean
