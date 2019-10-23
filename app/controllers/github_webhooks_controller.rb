require 'json'
class GithubWebhooksController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    include GithubWebhook::Processor
  
    def handle
        puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        puts JSON.pretty_generate(params.to_json)
        render :json => {"status": "success"}
    end
    def create
        puts "###################################################################################"
        # puts JSON.pretty_generate(params.to_json)
        render :json => {"name": "John", "age": 45}

    end

    # Handle push event
    def github_push(payload)
        puts "111111111111111111111111111111111111111"
        puts "push"
        puts "111111111111111111111111111111111111111"
    end
  
    # Handle create event
    def github_create(payload)
        puts "222222222222222222222222222222222222222222222222"
        puts "create"
        puts "222222222222222222222222222222222222222222222222"
    end
  
    private
  
    def webhook_secret(payload)
        "a_gr34t_s3cr3t"
    end
  end