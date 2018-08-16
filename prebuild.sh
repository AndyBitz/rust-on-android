# this will build the docker image for rust 1.28.0
docker build -f ./Dockerfile.build . -t rust-cross-to-arm-musleabihf:1.28.0
