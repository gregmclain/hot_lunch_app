class Student < ActiveRecord::Base
  has_many :orders, dependent:   :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :user
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :grade, presence: true

  def to_s
    "#{first_name} #{last_name}"
  end
end
