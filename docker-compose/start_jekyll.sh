#!/bin/sh

rm ../Gemfile.lock
docker run --rm \
  --mount type=bind,source=$PWD/..,target=/srv/jekyll \
  --publish 4000:4000 \
  --name jekyll \
  jekyll/jekyll:latest \
  jekyll serve --drafts
