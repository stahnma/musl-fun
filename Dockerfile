

from alpine

run apk update && apk add cmake boost-dev make curl git curl-dev ruby ruby-dev gcc g++ yaml-cpp-dev

run mkdir /workspace && cd workspace && \
git clone https://github.com/jbeder/yaml-cpp.git && \
git clone https://github.com/puppetlabs/leatherman &&\
git clone https://github.com/puppetlabs/libwhereami && \
git clone https://github.com/puppetlabs/cpp-hocon && \
git clone https://github.com/puppetlabs/facter && \
sed -i -e 's/sys\/poll/poll/' /usr/include/boost/asio/detail/socket_types.hpp
run cd /workspace/leatherman; mkdir build; cd build; cmake  -DBOOST_STATIC=OFF -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/cpp-hocon; mkdir build; cd build; cmake  -DBOOST_STATIC=OFF -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/libwhereami; mkdir build; cd build; cmake  -DBOOST_STATIC=OFF -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
#run cd /workspace/yaml-cpp; mkdir build; cd build; cmake  -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install
run cd /workspace/facter; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install

run apk add augeas ruby-augeas libressl-dev
run gem install --no-rdoc --no-ri deep_merge

run cd /workspace && git clone https://github.com/puppetlabs/pxp-agent && git clone https://github.com/puppetlabs/cpp-pcp-client
run cd /workspace/cpp-pcp-client &&  mkdir -p build; cd build; cmake ..  -DCMAKE_VERBOSE_MAKEFILE=ON ; make ; make install
run cd /workspace/pxp-agent && mkdir -p build; cd build; cmake ..  -DCMAKE_VERBOSE_MAKEFILE=ON; make; make install
run cd /workspace; curl -O -L https://people.redhat.com/~rjones/virt-what/files/virt-what-1.18.tar.gz && tar zxf virt-what-1.18.tar.gz && cd virt-what-1.18 && ./configure && make && make install

run cd /workspace && git clone https://github.com/puppetlabs/puppet && git clone https://github.com/puppetlabs/hiera  && cd hiera  && ./install.rb && cd ../puppet && ./install.rb


from alpine:latest
COPY --from=0 /usr/local/share /usr/local/share
COPY --from=0 /usr/local/bin /usr/local/bin
COPY --from=0 /usr/local/lib /usr/local/lib
