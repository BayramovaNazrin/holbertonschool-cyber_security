#!/bin/bash
# Extracts the payload after '{xor}' and decodes using Python
# Logic: Base64 decode -> XOR every byte with '_' (0x5F)

payload=${1#"{xor}"}
python3 -c "import sys, base64; print(''.join(chr(b ^ 95) for b in base64.b64decode(sys.argv[1])))" "$payload"
