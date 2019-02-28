require 'sinatra/base'
require './lib/bookmark'

class Bookmarks < Sinatra::Base
  get '/' do
    redirect ('/bookmarks')
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmark' do
    Bookmark.create(params[:url], params[:title])
    redirect ('/bookmarks')
  end

  post '/bookmark/:id/delete' do
    Bookmark.delete(params[:id])
    redirect ('/bookmarks')
  end

  get '/bookmarks/:id/update' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    @bookmark = connection.exec("select * from bookmarks where id = #{params['id']}")
    @bookmark = @bookmark.first
    erb :'bookmarks/edit'
  end

  post '/bookmarks/:id/patch' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    conection.exec("update bookmarks set url = '#{params['url']}', title = '#{params['title']}' where id = '#{params['id']}'")
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
