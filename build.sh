docker run \
  --rm \
  -v "$PWD":/usr/src/myapp \
  -w /usr/src/myapp \
  rust-cross-to-arm-musleabihf:1.28.0 \
  /root/.cargo/bin/cargo build $@
