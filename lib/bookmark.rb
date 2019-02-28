require 'pg'

class Bookmark
  attr_reader :url, :title, :id
  def self.all
    @bookmark_array =[]
    if ENV['RACK_ENV'] == 'test'
    conn = PG.connect(dbname: 'bookmark_manager_test' )
  else
    conn = PG.connect(dbname: 'bookmark_manager' )
  end
    conn.exec( "SELECT * FROM bookmarks" ) do |result|
      result.each do |row|
        @bookmark_array << Bookmark.new(row['url'],row['title'], row['id'])
      end
    end
    @bookmark_array
  end

  def self.create(url, title)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect(dbname: 'bookmark_manager' )
    end
      conn.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}');")
  end

  def initialize(url, title, id)
    @url = url
    @title = title
    @id = id
  end

  def self.delete(id)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect(dbname: 'bookmark_manager' )
    end
      conn.exec("DELETE FROM bookmarks WHERE id = '#{id}';")
  end
end
