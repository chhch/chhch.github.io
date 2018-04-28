#!/bin/sh

# Get project path
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"
PROJECT_PATH="$SCRIPT_PATH/.."

# Remove Gemfile.lock to get always the newest versions of the Gems
rm $PROJECT_PATH/Gemfile.lock

# Run the container and remove it when it finished
docker run --rm \
  --mount type=bind,source=$PROJECT_PATH,target=/srv/jekyll \
  --publish 127.0.0.1:4000:4000 \
  --name jekyll \
  jekyll/jekyll:latest \
  jekyll serve --drafts
