# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /build_files
COPY system_files /

# Base Image
FROM ghcr.io/ublue-os/base-main:latest

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_files/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
