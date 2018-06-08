class RepositoriesController < ApplicationController
  
  def index
    res = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    end
    @repos = JSON.parse(res.body)
  end

  def create
    # Faraday.post("https://api.github.com/user/repos") do |req|
    #   req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    #   req.body = {{name: params[:name]}.to_json => true}
    # end
    # redirect_to root_path
  end
end
