get '/' do
  #Hace una busqueda en los urls cuando el user_id sea nil, regresaré en la página principal el 
  #el último url acortado sin usuario en la vista principal(index)
  @url = Url.where(user_id: nil).last
  erb :index
end

