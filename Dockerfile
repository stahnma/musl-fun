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
run cd /workspace/facter; mkdir build; cd build; cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..; make ; make install

run apk add augeas ruby-augeas libressl-dev
run gem install --no-rdoc --no-ri deep_merge

run cd /workspace && git clone https://github.com/puppetlabs/pxp-agent && git clone https://github.com/puppetlabs/cpp-pcp-client
run cd /workspace/cpp-pcp-client &&  mkdir -p build; cd build; cmake ..  -DCMAKE_VERBOSE_MAKEFILE=ON ; make ; make install
run cd /workspace/pxp-agent && mkdir -p build; cd build; cmake ..  -DCMAKE_VERBOSE_MAKEFILE=ON; make; make install
run cd /workspace; curl -O -L https://people.redhat.com/~rjones/virt-what/files/virt-what-1.18.tar.gz && tar zxf virt-what-1.18.tar.gz && cd virt-what-1.18 && ./configure && make && make install

run  cd /workspace && git clone https://github.com/puppetlabs/hiera  && cd hiera && ./install.rb --no-configs --bindir=/usr/local/bin
run  cd /workspace && git clone https://github.com/puppetlabs/puppet && cd puppet && ./install.rb --bindir=/usr/local/bin --configdir=/etc/puppetlabs/puppet --codedir=/etc/puppetlabs/puppet/code --vardir=/usr/local/var/lib/puppet --logdir=/var/log/puppet --rundir=/var/run --quick


from alpine:latest
run apk update && apk add bash ruby curl yaml-cpp ruby-json ruby-augeas boost-random boost-iostreams boost-graph boost-signals boost boost-serialization boost-program_options boost-system boost-unit_test_framework boost-math boost-doc boost-wserialization boost-date_time boost-wave boost-filesystem boost-prg_exec_monitor boost-regex boost-thread &&  rm -rf  /var/cache/apk/*

COPY --from=0 /usr/lib/ruby/vendor_ruby/facter.rb /usr/lib/ruby/vendor_ruby/facter.rb
COPY --from=0 /etc/puppetlabs /etc/puppetlabs
COPY --from=0 /usr/local/share /usr/local/share
COPY --from=0 /usr/local/bin /usr/local/bin
COPY --from=0 /usr/local/lib /usr/local/lib

