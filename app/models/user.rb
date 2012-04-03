class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation, :display_name, :first_name, :last_name, :admin

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_one :cart

  def is_admin?
    admin
  end

  def name
    "#{first_name} #{last_name}"
  end

end