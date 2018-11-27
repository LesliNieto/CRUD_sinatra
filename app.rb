require 'sinatra'
require 'sinatra/activerecord'
require './environment'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

enable :sessions

class Post < ActiveRecord::Base
end

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :last_name, presence: true
  validates :email,presence: true
  validates :email, uniqueness: true
end

get "/users" do
  search = params[:search] || ''
  @user = User.where(
    "name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query OR age ILIKE :query", 
    query: "%#{search}%").order(:name)
  if @user.any?
    erb :"users/index"
  else
    redirect "/users", :error => "Record not found."
  end
end

get "/users/new" do
  erb :"users/new"
end

get "/users/:id" do
  @user = User.find(params[:id])
  erb :"users/show"
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :"users/edit"
end

post "/users/new" do
  @user = User.new(name: params[:name], last_name: params[:last_name], email: params[:email], age: params[:age], address: params[:address])
  if @user.save
    redirect "/users", :notice => 'User saved.'
  else
    redirect "/users/new", :error => 'This Email is already taken.'
  end
end

delete '/users/:id' do
  @user = User.delete(params[:id])
  redirect "/users",:notice => 'User deleted.'
end

put "/users/:id/update" do
  @user = User.find(params[:id])
  atrrs = {name: params[:name], last_name: params[:last_name], email: params[:email], age: params[:age], address: params[:address]}
  if @user.update(atrrs)
    redirect "/users/#{params[:id]}", :notice => 'User updated.'
  else
    redirect "/users/#{params[:id]}/edit", :error => 'This Email is already taken.'
  end
end