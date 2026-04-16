#!/usr/bin/python3
"""
Finds and replaces a string in the heap of a running process.
Usage: read_write_heap.py pid search_string replace_string
"""
import sys

def read_write_heap():
    # 1. Argument Validation
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not pid.isdigit():
        print("Error: PID must be an integer")
        sys.exit(1)

    # 2. Locate the Heap in /proc/[pid]/maps
    map_file = f"/proc/{pid}/maps"
    mem_file = f"/proc/{pid}/mem"
    
    heap_start = None
    heap_end = None

    try:
        with open(map_file, 'r') as f:
            for line in f:
                if "[heap]" in line:
                    # Line format: 555e646e0000-555e64701000 rw-p 00000000 00:00 0 [heap]
                    addr_range = line.split()[0]
                    start, end = addr_range.split('-')
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break
    except Exception as e:
        print(f"Error opening {map_file}: {e}")
        sys.exit(1)

    if heap_start is None:
        print("Error: Heap not found")
        sys.exit(1)

    print(f"[*] Found [heap] at: {hex(heap_start)} - {hex(heap_end)}")

    # 3. Read/Write to /proc/[pid]/mem
    try:
        with open(mem_file, 'rb+') as f:
            # Seek to start of heap
            f.seek(heap_start)
            heap_data = f.read(heap_end - heap_start)

            # Find the string
            try:
                offset = heap_data.index(bytes(search_str, "ascii"))
            except ValueError:
                print(f"Error: String '{search_str}' not found in heap")
                sys.exit(1)

            print(f"[*] Found '{search_str}' at offset {hex(offset)}")

            # Seek to the absolute address of the string
            f.seek(heap_start + offset)
            f.write(bytes(replace_str, "ascii"))
            
            # If the new string is shorter, you might want to overwrite 
            # the remaining old chars with a null byte, but usually 
            # simple replacement is expected here.
            
            print(f"[*] Successfully replaced with '{replace_str}'")
            print("SUCCESS!")

    except Exception as e:
        print(f"Error accessing memory: {e}")
        sys.exit(1)

if __name__ == "__main__":
    read_write_heap()
