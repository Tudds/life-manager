#!/bin/bash

# Script to generate config.js from Environment Variables on Vercel
# This runs during the build phase

echo "Generating config.js from environment variables..."

cat <<EOF > config.js
const CONFIG = {
    CLIENT_ID: '${CLIENT_ID}',
    API_KEY: '${API_KEY}',
    SPREADSHEET_ID: '${SPREADSHEET_ID}',
    SCOPES: 'https://www.googleapis.com/auth/spreadsheets',
    DISCOVERY_DOCS: ['https://sheets.googleapis.com/\$discovery/rest?version=v4']
};
EOF

echo "config.js generated successfully!"
