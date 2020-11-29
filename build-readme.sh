#!/usr/bin/env bash

project="$(basename "$(realpath .)" | sed -e 's/docker-//')"
tag="$(git branch --show-current)"

echo "building mck7/${project}:${tag}"

docker build --rm -t "mck7/${project}:${tag}" .


docker rm -f build-readme
docker run -itd --name build-readme "mck7/${project}:${tag}"
phpm="$(docker exec -it build-readme bash -c "php -m")"
headings="$(head -n2 README.md)"

echo "${headings}" > README.md
echo '```' >> README.md
echo "${phpm}" >> README.md
echo '```' >> README.md
