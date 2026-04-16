#!/usr/bin/python3
"""
Locates a string in the heap of a running process and replaces it.
Usage: read_write_heap.py pid search_string replace_string
"""
import sys

def read_write_heap():
    # 1. Validate arguments
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2].encode('ascii')
    replace_str = sys.argv[3].encode('ascii')

    # 2. Find the heap range in /proc/[pid]/maps
    try:
        with open(f"/proc/{pid}/maps", "r") as maps_file:
            heap_start = None
            heap_end = None
            for line in maps_file:
                if "[heap]" in line:
                    # Extract address range: e.g., "56d8cbf31000-56d8cbf52000"
                    addr_range = line.split()[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    break
            
            if heap_start is None:
                sys.exit(1)
    except Exception:
        sys.exit(1)

    # 3. Read and overwrite in /proc/[pid]/mem
    try:
        with open(f"/proc/{pid}/mem", "rb+") as mem_file:
            # Seek to start of heap and read its content
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            # Find the string index within the heap data
            try:
                index = heap_data.index(search_str)
            except ValueError:
                sys.exit(1)

            # Seek to the absolute memory location and overwrite
            mem_file.seek(heap_start + index)
            mem_file.write(replace_str)
            
            # Print ONLY the required success message
            print("SUCCESS!")

    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    read_write_heap()
