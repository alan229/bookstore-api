require 'octokit'

namespace :init_data do
  desc "TODO"
  task new_init_data: :environment do
    client = get_client
    client.auto_paginate = true
    init_data client
  end


  def get_client
    Octokit::Client.new(:access_token => '8942d9f6cdc90e5ac6240cf7b3d90713e456801f')
  end

  def init_data client
    pubs = []
    pubs<<pub1 = PublishingHouse.new(name: "ABC Publisher", discount: 40)
    pubs<<pub2 = PublishingHouse.new(name: "Acme Publishing House", discount: 50)
    pubs<<pub3 = PublishingHouse.new(name: "Foobar Corporation", discount: 55)
    pubs

    authors = []
    authors<<author1 = Author.new(name: "James Jackson", biography: "Hi, This is James Jackson")
    authors<<author2 = Author.new(name: "Roberta Rock", biography: "Hi, This is Roberta Rock")
    authors<<author3 = Author.new(name: "Daniel Duck", biography: "Hi, This is Daniel Duck")
    authors<<author4 = Author.new(name: "Amanda Djidjinski", biography: "Hi, This is Amanda")
    authors<<author5 = Author.new(name: "Zoe Zack", biography: "hi, This is Zoe")
    authors<<author6 = Author.new(name: "Bill Burray", biography: "Hi, This is Bill Burray")
    authors<<author7 = Author.new(name: "Charlie Chuck", biography: "Hi, This is Charlie")
    authors

    books = []
    books<<book1 = Book.new(title: "The Great Escape", author: author7, publisher: pub1, price: 24.20)
    books<<book2 = Book.new(title: "Saving Myself", author: author6, publisher: pub1, price: 14.13)
    books<<book3 = Book.new(title: "The Killer Doctors", author: author5, publisher: pub1, price: 15.12)
    books<<book4 = Book.new(title: "Marianne", author: author4, publisher: pub1, price: 10.50)
    books<<book5 = Book.new(title: "On the Verge of Salvation", author: author4, publisher: pub2, price: 11.76)
    books<<book6 = Book.new(title: "Fields of L", author: author3, publisher: pub2, price: 27.87)
    books<<book7 = Book.new(title: "Waterfront", author: author2, publisher: pub2, price: 11.97)
    books<<book8 = Book.new(title: "Bored as Hell", author: author6, publisher: pub3, price: 10.96)
    books<<book9 = Book.new(title: "History of the Silk Road", author: author7, publisher: pub3, price: 8.10)
    books<<booka = Book.new(title: "Something for Later", author: author1, publisher: author1, price: 9.54)
    books<<bookb = Book.new(title: "What If", author: author3, publisher: author3, price: 13.32)
    books<<bookc = Book.new(title: "Lilly Reborn", author: author4, publisher: pub3, price: 16.43)
    books<<bookd = Book.new(title: "Anathema", author: author5, publisher: author5, price: 9.41)
    books<<booke = Book.new(title: "Best Of", author: author2, publisher: pub3, price: 12.24)
    books<<bookf = Book.new(title: "Anyway", author: author6, publisher: pub3, price: 19.99)
    books

    puts 'Initializing authors data'
    authors.each do |author|
      author.save
      puts "Committed transaction: " + author.to_s
      client.create_issue('alan229/bookstore-api', author.name, author.biography)
    end

    puts 'Initializing publisher data'
    pubs.each do |pub|
      puts "Committed transaction: " + pub.to_s
      pub.save
    end

    puts 'Initializing books data'

    books.each do |book|
      puts "Committed transaction: " + book.to_s
      book.save
    end

  end
end
