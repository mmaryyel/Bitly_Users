post '/urls' do
  # crea una nueva Url
  @long_url = params[:long_url]
  #asignamos una nueva variable @url para poder llamarla en la vista
  @url = Url.new(long_url: @long_url)
  #si la @url cumple con todas las validaciones entonces la guarda
  if @url.save
    #si el usuario inicio sesión 
    if logged_in? 
      #tendra un id establecido de la sesión y las busquedad de las urls se guardaran 
      current_user.urls << @url
      #y se redicciona a la terminal de usuarios con el usuario que coincida con el id
      redirect to("/users/#{current_user.id}")
      #si no pertence a ningun usuario entonces se redirecciona a id
    else
      redirect to("/")
    end
  #si no, la variable donde se guarda la nueva url ingresada "@url"
  #la envia a la vista al igual que la variable que contiene la lista de urls 
  else
    #Cuándo si coincidan el usuario y el id se van a desplegar todas las busquedas de las urls
    #dentro de su perfil o vista "secret"
    @urls = Url.all
    erb :secret
  end
end


get '/url/:short_url' do
  puts "inside get"
  @url_selected = params[:short_url]
  object = Url.find_by({short_url: @url_selected})
  object.click_count += 1
  object.save
  p object 
  redirect to ("#{object.long_url}")
end