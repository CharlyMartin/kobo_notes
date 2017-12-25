require "sqlite3"
require "pry-byebug"
require_relative "methods"

DB = SQLite3::Database.new("input/KoboReader.sqlite")
DB.results_as_hash = true


# Extracting Text, Bookid and date from the
rows = DB.execute('
  SELECT Text, ContentID FROM Bookmark
  ORDER BY DateCreated ASC
')


# Finding unique keys as book titles
book_keys = extract_keys(rows);


# looping over the book keys
book_keys.each do |key|

  # creating an object for the current key
  data = {
    "#{key}" => []
  }

  # populating the object
  rows.each do |hash|
    data[key] << hash["Text"] if (hash["ContentID"].split('!')[0] == key)
  end

  save_as_txt(data)
end
