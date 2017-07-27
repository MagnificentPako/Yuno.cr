# Use crystal base image
FROM crystallang/crystal:latest AS compiler

# Set workdir to /yuno
WORKDIR /yuno

# Copy everything into workdir
COPY ./ .

# Downloads dependencies
RUN crystal deps update

# Compile
RUN crystal build src/Yuno.cr

# Compile urn
WORKDIR /urn
RUN apt-get update
RUN apt-get install -y lua5.2
RUN git clone https://gitlab.com/urn/urn.git .
RUN make

# Fetch stripcolorcodes
WORKDIR /misc
RUN apt-get install -y wget
RUN wget https://gist.githubusercontent.com/MagnificentPako/cb07a041b155e6212828a93929e2d1d0/raw/23e42091179ce3b3601a18930a7e8cfbfddf889b/stripcolorcodes

# Start actual image
FROM phusion/baseimage:latest

# Create non-root user
RUN groupadd -r yuno && useradd --no-log-init -r -g yuno yuno

# Install luajit and mueval
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y luajit
RUN apt-get install -y mueval

# Install stripcolorcodes
COPY --from=compiler /misc/stripcolorcodes /usr/bin/stripcolorcodes
RUN chmod +x /usr/bin/stripcolorcodes

# Copy urn into prod
WORKDIR /urn
COPY --from=compiler /urn/bin/urn.lua ./bin/urn.lua
COPY --from=compiler /urn/lib ./lib
RUN echo "#!/bin/bash\nluajit /urn/bin/urn.lua $@" > /usr/bin/urn
RUN chmod +x /usr/bin/urn

# Copy Yuno into prod
WORKDIR /yuno
COPY --from=compiler /yuno/Yuno .
COPY --from=compiler /yuno/wave.json .
RUN git clone https://github.com/MagnificentPako/YunoUrnLibs.git urn_std

# Chown everything as the new user
RUN chown -R yuno:yuno .

# Switch to new user
USER yuno

# Set entrypoint
ENTRYPOINT ./Yuno