# frozen_string_literal: true

require_relative 'setup_test_database'

describe Bookmark do
  describe '#all' do
    it 'returns bookmarks' do
      saved_bookmark = Bookmark.add(title: 'Makers', url: 'http://www.makersacademy.com')
      Bookmark.add(title: 'Destroy All Software', url: 'http://www.destroyallsoftware.com')
      Bookmark.add(title: 'Google', url: 'http://www.google.com')

      bookmarks = Bookmark.all
      # IMAGINE bookmarks = [ Bookmark.new(id: 'id', url: 'url', title: 'title'), ... ]
     
      bookmark_under_consideration = bookmarks[0]

      expect(bookmarks).to be_a Array
      expect(bookmarks.size).to eq 3
      expect(bookmark_under_consideration).to be_a Bookmark
      expect(bookmarks[2]).to be_a Bookmark
      
      # check title 
      expect(bookmark_under_consideration.title).to eq 'Makers'
      expect(bookmark_under_consideration.url).to eq 'http://www.makersacademy.com'
      expect(bookmark_under_consideration.id).to saved_bookmark.id
    end
  end

  describe '#add' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.add(url: 'http://www.example.org', title: 'Test Bookmark')
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
  
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.example.org'
    end
  end
end
