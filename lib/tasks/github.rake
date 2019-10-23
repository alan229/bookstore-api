require 'octokit'

namespace :github do
  desc "TODO"
  task read_issues: :environment do
    client = Octokit::Client.new(:access_token => 'f0dd8124ba44d1d011bc57615e5bbbf6a0c68ed3')
    client.auto_paginate = true

    open_issues = client.issues 'alan229/bookstore-api'
    open_issues.each do |i|
      puts i.title
      puts i.body

      a = Author.find_by(name: "#{i.title}")
      if a
        a.biography = i.body
      else
        a = Author.new({name: i.title, biography: i.body})
      end
      a.save
    end

    puts "----------------"
    deleted_issues = client.issues 'alan229/bookstore-api', {state: 'closed'}
    deleted_issues.each do |i|
      puts i.title
      puts i.body

      a = Author.find_by(name: "#{i.title}")
      a.delete if a
    end

  end

  task webhook: :environment do 
    require "octokit"
    client = Octokit::Client.new(:access_token => 'f0dd8124ba44d1d011bc57615e5bbbf6a0c68ed3')

    repo = "alan229/bookstore-api"
    callback_url = "https://6c6c9637.ngrok.io/github_webhooks"
    webhook_secret = "a_gr34t_s3cr3t"  # Must be set after that in ENV['GITHUB_WEBHOOK_SECRET']

    # Create the WebHook
    client.subscribe "https://github.com/#{repo}/events/issues/push.json", callback_url, webhook_secret
  end


  
end

