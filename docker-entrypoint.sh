#!/bin/bash
set -xeuo pipefail

wait-for-it db:5432

if [ "${1:-}" = "--" ]; then
   (bundle exec rake db:create || true)
   bundle exec rake db:migrate
   bundle exec rake assets:precompile

  set -- "foreman" "start" "-p" "3000"
fi

exec "$@"