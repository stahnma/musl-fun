

from alpine

run apk update && apk add cmake boost-dev make curl git curl-dev ruby ruby-dev gcc g++ yaml-cpp-dev

run mkdir /workspace && cd workspace && \
git clone https://github.com/jbeder/yaml-cpp.git && \
git clone https://github.com/puppetlabs/leatherman &&\
git clone https://github.com/puppetlabs/libwhereami && \
git clone https://github.com/puppetlabs/cpp-hocon && \
git clone https://github.com/puppetlabs/facter && \
sed -i -e 's/sys\/poll/poll/' /usr/include/boost/asio/detail/socket_types.hpp
run cd /workspace/leatherman; mkdir build; cd build; cmake  -DBOOST_STATIC=ON -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/cpp-hocon; mkdir build; cd build; cmake  -DBOOST_STATIC=ON -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/libwhereami; mkdir build; cd build; cmake  -DBOOST_STATIC=ON -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
#run cd /workspace/yaml-cpp; mkdir build; cd build; cmake  -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/facter; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install

ENTRYPOINT "/bin/sh"
