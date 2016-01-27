class CatRentalRequest < ActiveRecord::Base
  def overlapping_requests
    requests = CatRentalRequest
      .where("cat_rental_requests.start_date BETWEEN ? AND ?", start_date,end_date)
      .where("cat_rental_requests.end_date BETWEEN ? AND ?", start_date,end_date)
      .where(cat_id: cat_id)
      .where.not(id: id)
  end
  #
  def overlapping_approved_requests
    if status == "approved" && overlapping_requests.where(status: "approved")
      errors[:status] << "can't approve overlapping requests"
    end
  end
  validates :status, inclusion: %w(pending approved denied)
  validate :overlapping_approved_requests

  belongs_to :cat, :dependent => :destroy


end
