#Envía al usuario a la página(redirect to)si su informacion es correcta
#si intenta escribir el url desde el buscador este lo enviara a la vista principal
#y le solicitará iniciar sesión o crear una cuenta.
before '/users/:id' do
 if session[:id] == nil
    notlog = true
    redirect to ("/?notlog=#{notlog}")
  end
end


get '/login' do
  erb :login  
end

get '/signup' do
  erb :signup
end


#Obtiene un usuario y lo busca por su id y le muestra la vista de la página secreta
get '/users/:id' do
    @user = User.find(params[:id])
    #regresa todas las urls del usuario
    @urls = @user.urls
    erb :secret
end

post '/signup' do
  @user = User.new(name: params[:name], email: params[:email], password: params[:password])
  if @user.save
    @falla = false
    session[:id] = @user.id
    redirect to ("/users/#{@user.id}")
  else
    @falla = true
    erb :signup
  end
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])
  p user
  puts " SESSION ID ANTES #{session[:id]}"
  if user != nil
    session[:id] = user.id
    redirect to ("/users/#{user.id}")
  else
    @falla = true
    erb :login
  end
end



post '/logout' do
  session.clear
  redirect to ('/')
end