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

FROM phusion/baseimage:latest

# Create non-root user
RUN groupadd -r yuno && useradd --no-log-init -r -g yuno yuno

WORKDIR /yuno

COPY --from=compiler /yuno/Yuno .
COPY --from=compiler /yuno/wave.json .

# Chown everything as the new user
RUN chown -R yuno:yuno .

# Switch to new user
USER yuno

# Set entrypoint
ENTRYPOINT ./Yuno