def extract_keys(array)
  array.map {|item| item[1] }.uniq
end

def save_as_txt(obj)
  key = obj[:key]
  text = obj[:text].join("\n")
  date = obj[:date]
  file_path = "output/#{date} - #{key}.txt"

  File.open(file_path, "w") do |file|
    file.write(text)
  end
end
