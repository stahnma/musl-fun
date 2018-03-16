

from alpine

run apk update && apk add gcc cmake boost-dev yaml-cpp-dev openssl-dev ruby-dev make curl git g++ curl-dev
run mkdir /workspace ; cd workspace ; \
git clone https://github.com/puppetlabs/leatherman ;\
git clone https://github.com/puppetlabs/libwhereami ;\
git clone https://github.com/puppetlabs/cpp-hocon ;\
git clone https://github.com/puppetlabs/facter
run cd /workspace/leatherman; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/cpp-hocon; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/libwhereami; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run sed -i -e 's/sys\/poll/poll/' /usr/include/boost/asio/detail/socket_types.hpp
run apk add util-linux-dev ruby ruby-dev libblkid
run cd /workspace/facter; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install


ENTRYPOINT "/bin/sh"

