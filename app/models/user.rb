class User < ApplicationRecord
  attr_accessible :email, :password, :text_email, :username
end
