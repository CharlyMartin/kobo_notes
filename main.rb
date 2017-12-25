require "sqlite3"
require "pry-byebug"
require_relative "methods"

DB = SQLite3::Database.new("input/KoboReader.sqlite")
DB.results_as_hash = true


# Extracting Text, Bookid and date from the
rows = DB.execute('
  SELECT Text, VolumeID, DateCreated FROM Bookmark
  ORDER BY DateCreated ASC
')


# Finding unique keys as book titles
book_keys = extract_keys(rows);


# looping over the book keys
book_keys.each do |book_key|

  # creating an object for the current key
  data = {
    key: book_key,
    text: [],
    date: nil
  }

  # populating the object
  rows.each do |hash|
    data[:text] << hash["Text"] if (hash["VolumeID"] == book_key)
    data[:date] = hash["DateCreated"] if (hash["VolumeID"] == book_key)
  end

  save_as_txt(data)
end
