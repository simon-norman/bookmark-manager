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