class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :lockable
end
