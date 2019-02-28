require 'pg'

  def clear_test
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("TRUNCATE bookmarks;")
 end

  def create_bookmark(url, title)
    connection = PG.connect(dbname: 'bookmark_manager_test')
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id;")
    result.first['id']
  end

  def get_bookmark_by(field, value)
    results = connection.exec "SELECT * FROM bookmarks where #{field} = '#{value}'"
    
    retrieved_bookmark = {}
    results.each do |row|
      retrieved_bookmark.merge!(url: row['url'], title: row['title'])
    end

    retrieved_bookmark
  end