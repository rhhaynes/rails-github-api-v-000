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
    xx = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization" => "token #{session[:token]}"}, 'Content-Type' => 'application/json'}
      req.body = "{\"name\": \"a-new-repo\"}"
    end
    binding.pry
    redirect_to root_path
  end
end
