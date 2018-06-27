helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end
get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if a user nvaigates to the path "/signup",
    @user = User.new    # setup empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

get '/login'do
    erb(:login)
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    #1. find user by username
    user = User.find_by(username: username)
    
    if user && user.password == password
        session[:user_id] = user.id
        redirect to('/')
    else
        @error_message = "Login failed."
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
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
        redirect to('/login')
    else
        erb(:signup)
    end
end
get '/posts/new' do
    @post = FinstagramPost.new
    erb(:"posts/new")
end
post '/posts' do
    photo_url = params[:photo_url]
    
    # instantiate new Post
    @post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user
     })
    
    # if @post validates, save
    if @post.save
        redirect(to('/'))
    else
        erb(:"posts/new")
    end
end
get '/posts/:id' do
    @post = FinstagramPost.find(params[:id])
    erb(:"posts/show")
end
