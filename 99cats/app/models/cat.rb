class Cat < ActiveRecord::Base
  COLORS = {
    white: 0xFFFFFF,
    black: 0x000000,
    brown: 0x5C3317}

    COLOR_VALUES = {
      0xFFFFFF => "White",
      0x000000 => "Black",
      0x5C3317 => "Brown"}


  def self.colors
    COLORS
  end

  validates :birth_date, presence: true
  validates :name, presence: true
  validates :sex, inclusion: {in: %w(M F)}
  validates :color, inclusion: Cat.colors.values, allow_blank: true

  has_many :rentals, class_name: "CatRentalRequest"

  def age
    Time.now.year - birth_date.year
  end
end
