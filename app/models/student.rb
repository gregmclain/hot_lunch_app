class Student < ActiveRecord::Base
  has_many :orders, dependent:   :destroy
  belongs_to :user
  validates :name,  presence: true, length: { maximum: 50 }
  validates :grade, presence: true
end
