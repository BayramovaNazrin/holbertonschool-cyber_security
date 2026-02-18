import zlib
import struct

def create_simple_png():
    # PNG signature
    png_signature = b'\x89PNG\r\n\x1a\n'
    
    # IHDR chunk (image header)
    width = 32
    height = 32
    bit_depth = 8
    color_type = 2  # RGB
    compression = 0
    filter_method = 0
    interlace = 0
    
    ihdr_data = struct.pack('>IIBBBBB', 
                           width, height, bit_depth, 
                           color_type, compression, 
                           filter_method, interlace)
    ihdr_chunk = create_chunk(b'IHDR', ihdr_data)
    
    # Create a simple pattern (gradient from red to blue)
    # Each row has filter byte (0) + RGB data
    raw_data = bytearray()
    for y in range(height):
        raw_data.append(0)  # filter type: None
        for x in range(width):
            r = int(255 * x / width)
            g = int(128)
            b = int(255 * y / height)
            raw_data.extend([r, g, b])
    
    # Compress the image data
    compressed_data = zlib.compress(raw_data, level=9)
    idat_chunk = create_chunk(b'IDAT', compressed_data)
    
    # IEND chunk
    iend_chunk = create_chunk(b'IEND', b'')
    
    # Combine all parts
    png_data = png_signature + ihdr_chunk + idat_chunk + iend_chunk
    
    return png_data

def create_chunk(chunk_type, data):
    length = len(data)
    crc = zlib.crc32(chunk_type + data) & 0xffffffff
    return struct.pack('>I', length) + chunk_type + data + struct.pack('>I', crc)

# Generate PNG
png_bytes = create_simple_png()

# Save to file
with open('icon.png', 'wb') as f:
    f.write(png_bytes)

print(f"PNG created: {len(png_bytes)} bytes")
print("Saved as 'icon.png'")
