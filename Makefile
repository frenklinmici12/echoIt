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

# set up our program in the ethos vm 
# create client directory, install our program in the vm, encode it
install:
	(ethosParams client && cd client && ethosMinimaltdBuilder)
	install echoIt $(ETHOSROOT)/programs
	ethosStringEncode /programs/echoIt  > $(ETHOSROOT)/etc/init/console

# compile echoIt.go
# create ethos directory, copy packages into it (like altEthos, kernelTypes, etc..),
# then compile our .go file with the ethos compiler
echoIt: echoIt.go
	mkdir ethos
	cp -pr /usr/lib64/go/pkg/ethos_$(GOARCH)/* ethos
	ethosGo echoIt.go

# uninstall ethos "stuff"
clean:
	sudo rm -rf client ethos
	rm -f echoIt
	rm -f echoIt.goo.ethos
	

# this and sync not needed, just for speeding up development
reset:
	make clean

	git pull

	clear

	make && make install

sync:
	git commit -am "test"
	git push