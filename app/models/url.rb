class Url < ActiveRecord::Base
  # Remember to create a migration!
  before_create :shorten_url
  validates :long_url, format: { with: /\bhttp?|https?\b/,
    message: "URL invalida, necesita iniciar con http." } 

  def shorten_url
    self.short_url = (("A".."Z").to_a.sample(3) + (0..9).to_a.sample(3)).shuffle.join("")
  end
end
  

