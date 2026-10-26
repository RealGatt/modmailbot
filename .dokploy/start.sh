#!/bin/sh
set -eu
cd /app
# Run the checked-out Git code in a fresh container directory. Runtime state is
# mounted independently, and is never copied over by repository files.
tar -C /repo --exclude='./.git' --exclude='./.dokploy' --exclude='./node_modules' --exclude='./config.json' --exclude='./config.ini' --exclude='./.env' --exclude='./data' --exclude='./storage' --exclude='./db' --exclude='./logs' --exclude='./log' --exclude='./attachments' --exclude='./webpanel.json' --exclude='./testdata.json' --exclude='./build' -cf - . | tar -C /app -xf -
mkdir -p /opt/npm
(cd /opt/npm && bun add --exact npm@10.9.2 --ignore-scripts)
printf '#!/bin/sh\nexec /usr/local/bin/bun /opt/npm/node_modules/npm/bin/npm-cli.js "$@"\n' > /usr/local/bin/npm
chmod +x /usr/local/bin/npm
bun install --frozen-lockfile
exec /usr/local/bin/bun src/index.js
