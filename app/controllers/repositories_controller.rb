class RepositoriesController < ApplicationController
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
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
    conn = Faraday.new(:url => "https://api.github.com/user/repos")
    conn.post do |req|
      req.headers = {"Authorization" => "token #{session[:token]}"}
      req.body = {"name": JSON.generate(params[:name])}
    end
    redirect_to root_path
  end
end
