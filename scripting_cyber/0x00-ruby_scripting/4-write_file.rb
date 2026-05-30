#!/usr/bin/env ruby
require 'json'

def merge_json_files(file1_path, file2_path)
  # 1. Read and parse the content of the first file
  file1_content = File.read(file1_path)
  data1 = JSON.parse(file1_content)

  # 2. Read and parse the content of the second file
  file2_content = File.read(file2_path)
  data2 = JSON.parse(file2_content)

  # 3. Merge the data. If they are arrays, '+' joins them together.
  # If they are hashes, you would use 'data2.merge(data1)' instead.
  merged_data = data2 + data1

  # 4. Convert the merged Ruby data back into a pretty JSON string
  # and write it back into file2_path
  File.open(file2_path, 'w') do |f|
    f.write(JSON.pretty_generate(merged_data))
  end
end
