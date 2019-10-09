class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

         def self.create_from_provider_data(provider_data)
          where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
            puts '-------------------------'
            puts provider_data.info.inspect
            # user.name = provider_data.info
            user.email = provider_data.info.email
            user.password = Devise.friendly_token[0, 20]
            user.role = 'student'
            # user.skip_confirmation!
          end
        end
  
end