FROM alpine:edge

# pugixml-dev is in edge/testing
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  # Dev
  binutils \
  boost-dev \
  build-base \
  clang \
  cmake \
  crypto++-dev \
  gcc \
  gmp-dev \
  luajit-dev \
  make \
  mariadb-connector-c-dev \
  pugixml-dev \
  # Run
  boost-iostreams \
  boost-system \
  crypto++ \
  gmp \
  luajit \
  mariadb-connector-c \
  pugixml

# Copy code and cmake files to container
COPY cmake /usr/src/forgottenserver/cmake/
COPY src /usr/src/forgottenserver/src/
COPY CMakeLists.txt /usr/src/forgottenserver/

# Builds the server
WORKDIR /usr/src/forgottenserver/build
RUN cmake .. && make 

# Copy config files to container
COPY data /srv/data
COPY LICENSE README.md *.dist *.lua *.sql key.pem /srv/

# Organize binaries internally
RUN cp /usr/src/forgottenserver/build/tfs /bin/tfs
RUN ln -s /usr/lib/libcryptopp.so /usr/lib/libcryptopp.so.5.6

EXPOSE 7171 7172
VOLUME /srv
WORKDIR /srv

# Run the server!
ENTRYPOINT ["/bin/tfs"]