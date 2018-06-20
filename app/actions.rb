get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if a user nvaigates to the path "/signup",
    @user = User.new    # setup empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

post '/signup' do
    email       = params[:email]
    avatar_url  = params[:avatar_url]
    username    = params[:username]
    password    = params[:password]
    
    # instantiate and save a User
    @user = User.new({ email: email, avatar_url:avatar_url, username: username, password: password})
    
    # if user validations pass and user is saved
    if @user.save
        "User #{username} saved!"
    else
        erb(:signup)
    end
end