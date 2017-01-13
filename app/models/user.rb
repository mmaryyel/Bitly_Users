class User < ActiveRecord::Base
  # Remember to create a migration!
  #crea un método con el nombre urls que muestre todas las urls
  #asociadas con el usuario.
  has_many :urls
  validates :name, :email, :password, presence: true
#validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user
      user.password === password ? user : nil
    end
  end
end