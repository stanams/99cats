class Cat < ActiveRecord::Base
  COLORS = [0xFFFFFF, 0x000000, 0x5C3317]

  def self.colors
    COLORS
  end

  validates :birth_date, presence: true
  validates :name, presence: true
  validates :sex, inclusion: {in: %w(M F)}
  validates :color, inclusion: Cat.colors, allow_blank: true


  def age
    Time.now.year - birth_date.year
  end
end
