class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find(params[:cat_id])
    @rentals = CatRentalRequest.where(cat_id: @cat.id)
    render :index
  end

  def show
    @rental = CatRentalRequest.find(params[:id])
    render :show
  end

  def create
    @rental = CatRentalRequest.new(rental_params)
    if @rental.save
      redirect_to rental_url(@rental)
    else
      render @rental.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @rental = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def edit
  end

  def update
  end

  private
  def rental_params
   params.
     require(:cat_rental_request).
     permit(:cat_id,:start_date,:end_date)
  end
end
