class Student < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  validates :grade, presence: true
end
