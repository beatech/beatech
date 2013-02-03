class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :account, :password_digest, :password, :password_confirmation

  class << self
    def authenticate(account, password)
      user = find_by_account(account, password)
      if user && user.password_digest.present? &&
          BCrypt::Password.new(user.password_digest) == password
        user
      else
        nil
      end
    end
  end
end
