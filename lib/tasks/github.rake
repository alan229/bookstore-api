require 'octokit'

namespace :github do
  desc "TODO"
  task read_issues: :environment do
    client = Octokit::Client.new(:access_token => '8942d9f6cdc90e5ac6240cf7b3d90713e456801f')
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
    client = Octokit::Client.new(:access_token => '8942d9f6cdc90e5ac6240cf7b3d90713e456801f')

    repo = "alan229/bookstore-api"
    callback_url = "https://0b87f2cb.ngrok.io/github_webhooks"
    webhook_secret = "a_gr34t_s3cr3t"  # Must be set after that in ENV['GITHUB_WEBHOOK_SECRET']

    # Create the WebHook
    client.subscribe "https://github.com/#{repo}/events/issues/push.json", callback_url, webhook_secret
  end


  
end

