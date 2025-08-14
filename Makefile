export LDIR= .
export UDIR= .
export GOC = x86_64-xen-ethos-6g
export GOL = x86_64-xen-ethos-6l
export ETN2GO = etn2go
export ET2G   = et2g
export EG2GO  = eg2go

export GOARCH = amd64
export TARGET_ARCH = x86_64
export GOETHOSINCLUDE=ethos
export GOLINUXINCLUDE=linux

export ETHOSROOT=client/rootfs
export MINIMALTDROOT=client/minimaltdfs
export ROOTFS=`pwd`/client/rootfs

.PHONY: all install clean
all: echoIt

install:
	(ethosParams client && cd client && ethosMinimaltdBuilder)
	install echoIt client/rootfs/programs
	ethosStringEncode /programs/echoIt  > client/rootfs/etc/init/console

echoIt: echoIt.go
	mkdir ethos
	cp -pr /usr/lib64/go/pkg/ethos_$(GOARCH)/* ethos
	ethosGo echoIt.go

run:
	(cd client; sudo ethosRun -t; ethosLog .)

# Bad practice, don't write targets like this
rebuild: clean all install

clean:
	sudo rm -rf client ethos
	rm -f echoIt
	rm -f echoIt.goo.ethos
	

reset:
	sudo rm -rf client ethos
	rm -f echoIt
	rm -f echoIt.goo.ethos

	git pull

	clear

	make && make install

sync:
	git commit -am "test"
	git push