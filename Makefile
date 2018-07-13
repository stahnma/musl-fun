


create:
	docker run --name builder -v v:/workspace -t -d alpine


deps:
	docker exec builder apk update
	docker exec builder apk add gcc cmake boost-dev yaml-cpp-dev openssl-dev ruby-dev make curl

build:
	docker exec builder make -f workspace/Makefile


clean:
	rm -rf v workspace
	docker stop builder

volume:
	mkdir -p v
	git clone https://github.com/puppetlabs/leatherman v/leatherman
	git clone https://github.com/puppetlabs/libwhereami v/libwhereami
	git clone https://github.com/puppetlabs/cpp-hocon v/cpp-hocon
	git clone https://github.com/puppetlabs/facter v/facter
	mkdir -p workspace




