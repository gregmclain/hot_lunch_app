class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :students, dependent:   :destroy
  has_many :transactions, dependent:   :destroy

  def display_name
    "#{email}"
  end
end
