# Kong
#
# VERSION       0.0.1-beta

# use the Openresty base image provided by Mashape
FROM mashape/docker-openresty
MAINTAINER Marco Palladino, marco@mashape.com

ENV KONG_VERSION 0.0.1-beta

# download Kong
RUN wget https://github.com/Mashape/kong/archive/$KONG_VERSION.tar.gz && tar xzf $KONG_VERSION.tar.gz

# moving kong to a default directory "kong"
RUN mv kong-$KONG_VERSION kong-src

# install Kong
RUN cd kong-src && make install

# copy configuration files
ADD config.docker/* kong-src/config.default/

# run Kong
CMD cd /kong-src && bin/kong migrate && bin/kong start

EXPOSE 8000 8001