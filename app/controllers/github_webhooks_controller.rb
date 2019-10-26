require 'json'
class GithubWebhooksController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    include GithubWebhook::Processor
  
    def create
        github_webhook = JSON.parse(params.to_json)["github_webhook"]
        name = github_webhook["issue"]["title"]
        bio = github_webhook["issue"]["body"]
        action = github_webhook["action"]
        deleted_actions = ['closed', 'deleted']

        case action
        
        when 'opened'
            puts 'created'
            save_author(name, bio)
        when 'edited'
            puts 'modified'
            modify_author(name, bio)
        when *deleted_actions
            puts 'closed'
            delete_author(name)
        else
            puts "Invalid action: #{action}"
        end
        render :json => {"status": "success"}
    end

 
    private
  
    def webhook_secret(payload)
        "a_gr34t_s3cr3t"
    end

    def save_author(name, bio)
        a = Author.find_by(name: name)
        if a
            a.biography = bio
        else
            a = Author.new({name: name, biography: bio})
        end
        a.save
    end

    def modify_author(name, bio)
        a = Author.find_by(name: name)
        if a
            a.name = name
            a.biography = bio
        end
        a.save
    end

    def delete_author(name)
        a = Author.find_by(name: name)
        a.delete if a
    end

  end