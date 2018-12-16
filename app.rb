require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	#@error = 'something'
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	# user_name, phone, date_time
	@user_name = params[:username]
	@phone = params[:phone]
	@date_time = params[:datetime]
	@barber = params[:barber]
	#https://github.com/tkrotoff/jquery-simplecolorpicker
	@color = params[:color]

	if @user_name == ''
		@error = 'Enter your name!'
		return erb :visit
	end

	@title = "Thank you!"
	@message = "Dear #{@user_name}, your color is #{@color}, #{@barber} will wait for you on #{@date_time}"
		
  # save info to file
 	f = File.open './public/users.txt', 'a'
	f.write "#{@user_name}, color: #{@color}, phone: #{@phone}, date and time: #{@date_time}, barber: #{@barber}\n"
	f.close

	erb :message
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	# email, umessage
	@email = params[:email]
	@umessage = params[:umessage]

	@title = "Thanks for your message!"
	@message = "We'll send all info to your e-mail: #{@email}"
		
  # save info to file
 	f = File.open './public/contacts.txt', 'a'
	f.write "#{@email} : #{@umessage}\n\n"
	f.close

	erb :message
end

#admin access to get list from file
get '/admin' do
	erb :admin
end

post '/admin' do
	@password = params[:password]

	if @password == 'secret'
		erb :admin_inside
	else
		@message = 'Access denied!!!'
		erb :admin
	end
end

post '/admin_inside' do
	@butt = params[:butt]

	if @butt == 'list'
		@file = File.open("./public/users.txt","r")
		erb :users_list	
	else
		@file = File.open("./public/contacts.txt","r")
		erb :users_contacts
	end
end