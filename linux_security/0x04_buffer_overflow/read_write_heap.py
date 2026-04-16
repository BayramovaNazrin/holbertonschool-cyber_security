#!/usr/bin/python3
"""
Locates a string in the heap of a running process and replaces it.
"""
import sys
import os

def print_error_and_exit(msg):
    """Prints error message and exits with status 1."""
    print(msg)
    sys.exit(1)

def read_write_heap():
    """Main logic to find and replace string in process heap."""
    if len(sys.argv) != 4:
        print_error_and_exit("Usage: read_write_heap.py pid search_string replace_string")

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print_error_and_exit("PID must be a number")

    search_str = sys.argv[2].encode('ascii')
    replace_str = sys.argv[3].encode('ascii')

    # Paths to memory maps and actual memory
    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    if not os.path.exists(maps_path):
        print_error_and_exit(f"Process {pid} not found in /proc")

    heap_start = None
    heap_end = None

    # Step 1: Find the heap address range in /proc/[pid]/maps
    try:
        with open(maps_path, 'r') as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    print(f"[*] Found [heap] at: {hex(heap_start)} - {hex(heap_end)}")
                    break
    except PermissionError:
        print_error_and_exit("Permission denied reading maps. Run as sudo.")

    if not heap_start:
        print_error_and_exit("Heap not found for this process.")

    # Step 2: Search and Replace in /proc/[pid]/mem
    try:
        with open(mem_path, 'rb+') as mem_file:
            # Move file pointer to start of heap
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            # Find the string
            idx = heap_data.find(search_str)
            if idx == -1:
                print_error_and_exit(f"String '{sys.argv[2]}' not found in heap.")

            print(f"[*] Found '{sys.argv[2]}' at offset {hex(idx)}")

            # Move pointer to the exact location of the string and overwrite
            mem_file.seek(heap_start + idx)
            mem_file.write(replace_str)
            # Optional: if new string is shorter, you might want to null-terminate
            # mem_file.write(b'\0') 
            
            print(f"[*] Successfully replaced with '{sys.argv[3]}'")

    except PermissionError:
        print_error_and_exit("Permission denied accessing memory. Run as sudo.")
    except Exception as e:
        print_error_and_exit(f"An error occurred: {e}")

if __name__ == "__main__":
    read_write_heap()
