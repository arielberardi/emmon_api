# frozen_string_literal: true

class User < ActiveRecord::Base
  # This fix "undefined Devise error" (see if there is anothers problems in sessions)
  extend Devise::Models 
  include DeviseTokenAuth::Concerns::User
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

end
