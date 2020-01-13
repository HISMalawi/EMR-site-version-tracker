class User < ApplicationRecord
  self.table_name = :users
  self.primary_key = :user_id

  cattr_accessor :current

  has_secure_password  
  validates :email, presence: true, uniqueness: true


end
