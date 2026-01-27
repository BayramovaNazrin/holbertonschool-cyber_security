import base64

# Yakaladığın Base64 string
cipher_b64 = "Dz58MhM+B20pNxAQBiYcLmorHjstCjwaKA=="
data = base64.b64decode(cipher_b64)

print(f"{'Key':<5} | {'Decoded String'}")
print("-" * 40)

for key in range(256):
    try:
        # Her byte'ı mevcut anahtar (key) ile XOR'la
        decoded = "".join(chr(b ^ key) for b in data)
        
        # Sadece harf, rakam ve standart sembollerden oluşan sonuçları filtrele
        if all(32 <= ord(c) <= 126 for c in decoded):
            print(f"{key:<5} | {decoded}")
    except:
        continue
