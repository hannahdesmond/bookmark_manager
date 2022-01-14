# frozen_string_literal: true

require 'pg'
# this class makes bookmarks
class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    connection = connect

    result = connection.exec('SELECT * FROM bookmarks')
    
    # this returns an object that is all of the bookmarks
    # each bookmark's attributes can be accessed in a hash
    # by calling the index on the method result[0] or result[2]
  end

  def self.add(title:, url:)
    connection = connect
    result = connection.exec_params("INSERT INTO bookmarks (title, url) VALUES ($1, $2) RETURNING id, url, title", [title, url])
    
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  private 

  def self.connect
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
