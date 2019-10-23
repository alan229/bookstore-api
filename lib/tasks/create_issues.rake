require 'octokit'

namespace :create_issues do
  desc "TODO"
  task create_authors: :environment do
    client = Octokit::Client.new(:access_token => 'f0dd8124ba44d1d011bc57615e5bbbf6a0c68ed3')

    client.auto_paginate = true

    client.create_issue('alan229/bookstore-api', 'title', body = 'bio', options = {})

    # issues = client.issues 'alan229/bookstore-api'
    # issues.each do |i|
    #   # puts i.id
    #   puts i.title
    #   puts i.body

    #   a = Author.new({name: i.title, biography: i.body})
    #   # a.save
    # end


  end

end

