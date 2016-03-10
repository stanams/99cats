class CatRentalRequest < ActiveRecord::Base
  def overlapping_requests
    requests = CatRentalRequest
      .where.not("? < ALL (cat_rental_requests.end_date,cat_rental_requests.start_date)", end_date)
      .where.not("? > ALL (cat_rental_requests.end_date,cat_rental_requests.start_date)", start_date)
      .where(cat_id: cat_id)
      .where.not(id: id)

  end
  #
  def overlapping_approved_requests
    if status == "approved" && overlapping_requests.where(status: "approved").count > 0
      errors[:status] << "can't approve overlapping requests"
    end
  end

  def start_before_end_date
    if end_date < start_date
      errors[:start_date] << "start date must be before end date"
    end
  end

  def approve!
    if overlapping_requests.where(status: "approved").count > 0
      raise "There is already an approved request for those dates"
    else
      # @status = "approved"
      CatRentalRequest.transaction do
        update!(status: "approved")
        overlapping_requests.where(status: "pending").each do |request|
          request.deny!
        end
      end
    end
  end

  def deny!
    # @status = "denied"
    update(status: "denied")
  end

  validates :status, inclusion: %w(pending approved denied)
  validate :overlapping_approved_requests
  validate :start_before_end_date
  belongs_to :cat, :dependent => :destroy


end
