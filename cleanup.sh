#!/bin/bash

set -e

cd "$(dirname "$0")/vite-project"

echo "Cleaning up misplaced build files in vite-project/ ..."

# Remove files that should not be in the root (except config, src, public, dist, node_modules, etc.)
find . -maxdepth 1 -type f \( -name "*.js" -o -name "*.css" -o -name "*.html" -o -name "*.map" \) -exec rm -v {} \;

# Remove any static or assets folders in the root (except dist/assets)
for d in static assets; do
  if [ -d "$d" ] && [ "$d" != "dist" ]; then
    rm -rfv "$d"
  fi
done

echo "Ensuring dist/ exists and contains index.html ..."
if [ -d dist ] && [ -f dist/index.html ]; then
  echo "dist/ is present and contains index.html"
else
  echo "dist/ is missing or incomplete. Please run 'npm run build' in vite-project/"
  exit 1
fi

echo "Directory structure after cleanup:"
tree -L 2

echo "Cleanup and verification complete."