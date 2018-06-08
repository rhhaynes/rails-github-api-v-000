class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  
  def create
    body_params = {
      "client_id" => ENV["GITHUB_CLIENT_ID"],
      "client_secret" => ENV["GITHUB_CLIENT_SECRET"],
      "code" => params["code"]}
    res = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {"Accept" => "application/json"}
      req.body = body_params
    end
    session[:token] = JSON.parse(res.body)["access_token"]
    redirect_to root_path
  end
end