class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews
  has_one_attached :photo

#validations
  # validates :model, presence: true
  # validates :year, presence: true
  # validates :price, presence: true, numericality: true
  # validates :manufacturer, presence: true
  
  def initialize(attrs)
    require 'open-uri'
    photo = attrs.delete(:photo) if attrs
    super
    self.photo.attach(io: open(photo), filename: 'x') if photo
  end
end
