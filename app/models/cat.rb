class Cat < ActiveRecord::Base
  validates :birth_date, presence: true
  validates :name, presence: true
  validates :sex, inclusion: {in: %w(M F)}
  validates :color, inclusion: {in: [0xFFFFFF]}


  # COLORS = [
  #   0xFFFFFF
  # ]
  #
  # def self.colors
  #   COLORS
  # end

  def age
    Time.now.year - birth_date.year
  end
end
