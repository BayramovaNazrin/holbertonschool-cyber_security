#!/bin/bash
# 1-xor_decoder.sh

# Argüman kontrolü
if [ -z "$1" ]; then
    echo "Kullanım: $0 {xor}HASH"
    exit 1
fi

# {xor} prefix'ini temizle
payload=${1#"{xor}"}

# Python ile güvenli ve hatasız decode işlemi
# Logic: Base64 decode -> XOR 95 (_) -> Output
python3 -c "import sys, base64; data = base64.b64decode(sys.argv[1]); print(''.join(chr(b ^ 95) for b in data))" "$payload"
