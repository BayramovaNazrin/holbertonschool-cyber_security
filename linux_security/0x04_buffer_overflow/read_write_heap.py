#!/usr/bin/python3
import sys

def usage():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

# ---- Args ----
if len(sys.argv) != 4:
    usage()

pid, search, replace = sys.argv[1], sys.argv[2], sys.argv[3]

try:
    pid = int(pid)
except ValueError:
    usage()

try:
    search_b = search.encode("ascii")
    replace_b = replace.encode("ascii")
except Exception:
    print("Error: strings must be ASCII")
    sys.exit(1)

if len(search_b) != len(replace_b):
    print("Error: search and replace must be same length")
    sys.exit(1)

maps_path = f"/proc/{pid}/maps"
mem_path = f"/proc/{pid}/mem"

# ---- Find heap ----
heap_start = None
heap_end = None

with open(maps_path, "r") as maps:
    for line in maps:
        if "[heap]" in line:
            addr = line.split()[0]
            start, end = addr.split("-")
            heap_start = int(start, 16)
            heap_end = int(end, 16)
            break

if heap_start is None:
    print("Error: heap not found")
    sys.exit(1)

# ---- Read + Write ----
try:
    with open(mem_path, "r+b", 0) as mem:
        addr = heap_start

        while addr < heap_end:
            mem.seek(addr)
            chunk = mem.read(len(search_b))

            if chunk == search_b:
                mem.seek(addr)
                mem.write(replace_b)
                break

            addr += 1

except PermissionError:
    print("Error: permission denied")
    sys.exit(1)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
