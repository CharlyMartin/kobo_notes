def extract_keys(array)
  array.map {|item| item[1].split('!')[0] }.uniq
end

def save_as_txt(hash)
  key = hash.keys.first
  text = hash[key].join("\n")
  file_path = "notes/#{key}.txt"

  File.open(file_path, "w") do |file|
    file.write(text)
  end
end
