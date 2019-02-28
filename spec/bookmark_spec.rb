require 'bookmark'

describe Bookmark do
  let(:connection) { PG.connect(dbname: 'bookmark_manager_test') }
  let(:bookmark1) { { url: 'http://www.makersacademy.com', title: 'Makers' } }
  let(:bookmark2) { { url: 'http://www.destroyallsoftware.com', title: 'DAS' } }

  describe '#all' do
    before(:each) do
      @bookmark1_id = create_bookmark(bookmark1[:url], bookmark1[:title])
      @bookmark2_id = create_bookmark(bookmark2[:url], bookmark2[:title])
    end

    it 'returns all bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq(2)
    end

    describe 'with each bookmark including' do
      it 'title' do
        expect(Bookmark.all.last.title).to eq(bookmark2[:title])
      end

      it 'url' do
        expect(Bookmark.all.last.url).to eq(bookmark2[:url])
      end

      it 'id' do
        expect(Bookmark.all.last.id).to eq(@bookmark2_id)
      end
    end
  end

  describe '#create' do
    it 'adds a new bookmark url to the database' do
      Bookmark.create(bookmark1[:url], bookmark1[:title])

      retrieved_bookmark = get_bookmark_by('url', bookmark1[:url])
      expect(retrieved_bookmark).to eq(bookmark1)
    end
  end

  describe '#delete' do
    it 'deletes a bookmark from the database' do
      bookmark_id = create_bookmark(bookmark1[:url], bookmark1[:title])

      Bookmark.delete(bookmark_id)

      retrieved_bookmark = get_bookmark_by('id', bookmark_id)
      expect(retrieved_bookmark).to be_empty
    end
  end
end
