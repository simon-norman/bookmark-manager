require 'pg'

class Bookmark
  attr_reader :url, :title
  def self.all
    @bookmark_array =[]
    if ENV['RACK_ENV'] == 'test'
    conn = PG.connect(dbname: 'bookmark_manager_test' )
  else
    conn = PG.connect(dbname: 'bookmark_manager' )
  end
    conn.exec( "SELECT * FROM bookmarks" ) do |result|
      result.each do |row|
        @bookmark_array << Bookmark.new(row['url'],row['title'])
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

  def initialize(url,title)
    @url = url
    @title = title
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
