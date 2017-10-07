#!/bin/sh

# Remove Gemfile.lock to get always the newest versions of the Gems
rm ../Gemfile.lock

# Run the container and remove it when it finished
docker run --rm \
  --mount type=bind,source=$PWD/..,target=/srv/jekyll \
  --publish 127.0.0.1:4000:4000 \
  --name jekyll \
  jekyll/jekyll:latest \
  jekyll serve --drafts
