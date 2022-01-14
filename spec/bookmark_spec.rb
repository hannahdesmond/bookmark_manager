# frozen_string_literal: true

require_relative 'setup_test_database'

describe Bookmark do
  describe '#all' do
    it 'returns bookmarks' do
      add_test_bookmarks

      bookmarks = Bookmark.all
      # bookmarks is [Bookmark.new, {id=>'id', title=>'title', url='url'} {etc} ]
      # we want this method to return an array of bookmarks
      # each with id, url and title. 
      expect(bookmarks).to_be an_array
      expect(bookmarks.size).to eq 3
      expect(bookmarks[0]).to be_a Bookmark
      expect(bookmarks[2]).to be_a Bookmark
      # check title 
      expect(bookmarks[0]).
      expect(bookmarks).to include 'Google'
      expect(bookmarks).to include 'Makers'
      expect(bookmarks).to include 'Destroy All Software'
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
