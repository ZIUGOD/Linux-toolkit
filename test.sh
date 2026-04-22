#!/usr/bin/env bash

set -e  # Exit on error
set -o pipefail

echo "=== [1] Updating system and installing dependencies ==="

if command -v apt-get >/dev/null 2>&1; then
    apt-get update -y
    apt-get install -y python3 python3-pip curl jq
elif command -v apk >/dev/null 2>&1; then
    apk add --no-cache python3 py3-pip curl jq
else
    echo "Unsupported package manager"
    exit 1
fi

echo "=== [2] Python version check ==="
python3 --version

echo "=== [3] Creating virtual environment ==="
python3 -m venv venv
. venv/bin/activate

echo "=== [4] Installing Python packages ==="
pip install --upgrade pip
pip install requests

echo "=== [5] Creating test Python script ==="

cat <<EOF > test_script.py
import requests

print("Running HTTP request...")
response = requests.get("https://api.github.com")

print("Status Code:", response.status_code)

if response.status_code != 200:
    raise Exception("Request failed")

data = response.json()
print("GitHub API message:", data.get("current_user_url", "N/A"))
EOF

echo "=== [6] Running Python script ==="
python test_script.py

echo "=== [7] Performing shell HTTP request ==="
HTTP_RESPONSE=$(curl -s -o response.json -w "%{http_code}" https://jsonplaceholder.typicode.com/posts/1)

echo "HTTP Status: $HTTP_RESPONSE"

if [ "$HTTP_RESPONSE" -ne 200 ]; then
    echo "HTTP request failed"
    exit 1
fi

echo "=== [8] Parsing JSON ==="
TITLE=$(jq -r '.title' response.json)
echo "Post title: $TITLE"

if [ -z "$TITLE" ] || [ "$TITLE" == "null" ]; then
    echo "Invalid JSON parsing"
    exit 1
fi

echo "=== [9] File operations ==="
mkdir -p output
cp response.json output/
ls -lah output/

echo "=== [10] Simulating conditional logic ==="
if [ "$TITLE" == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit" ]; then
    echo "Title matches expected value"
else
    echo "Unexpected title"
    exit 1
fi

echo "=== [11] Cleanup ==="
deactivate
rm -rf venv test_script.py response.json

echo "=== PIPELINE TEST COMPLETED SUCCESSFULLY ==="
