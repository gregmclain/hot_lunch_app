class Student < ActiveRecord::Base
  has_many :orders, dependent:   :destroy
  belongs_to :user
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :grade, presence: true
end
