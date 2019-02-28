require 'bookmark'

describe Bookmark do
  let(:connection) {PG.connect(dbname: 'bookmark_manager_test')}
  describe '#all' do
    it 'returns all bookmarks' do
      create_bookmark('http://www.makersacademy.com', 'Makers')
      create_bookmark('http://www.destroyallsoftware.com', 'DAS')

      bookmarks = Bookmark.all

      expect(bookmarks.pop.url).to include("http://www.destroyallsoftware.com")
    end
  end

  describe '#create' do
    it 'adds a new bookmark url to the database' do
      bookmark = {
        url: 'https://github.com',
        title: 'Github'
      }
      Bookmark.create(bookmark[:url], bookmark[:title])

      retrieved_bookmark = {}
      results = connection.exec "SELECT * FROM bookmarks where url = '#{bookmark[:url]}'"
      results.each do |row|
        retrieved_bookmark.merge!(url: row['url'], title: row['title'])
      end

      expect(retrieved_bookmark).to eq(bookmark)
    end
  end

  describe '#delete' do
    it 'deletes a bookmark from the database' do
      bookmark = create_bookmark('http://www.makersacademy.com', 'Makers')
      Bookmark.delete(bookmark[:id])

      retrieved_bookmark = {}
      results = connection.exec "SELECT * FROM bookmarks where id = '#{id}'"
      p results

      expect(retrieved_bookmark).to eq(bookmark)
    end
  end
end
