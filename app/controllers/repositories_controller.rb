class RepositoriesController < ApplicationController
  
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
  
  
  def index
    res_user = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {"Authorization" => "token #{session[:token]}"}
    end
    res_repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization" => "token #{session[:token]}"}
    end
    @user  = JSON.parse(res_user.body)
    @repos = JSON.parse(res_repos.body)
  end

  def create
    Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
