class PinsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote ]

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def new
    @pin = current_user.pins.build
  end

  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin was Successfully updated! "
    else
      render 'edit'
    end
  end

  def destroy
    if @pin.destroy
      redirect_to root_path
    else
      flash[:notice] = "Something is wrong "
    end
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back 
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin,
      notice: "Successfully created new Pin"
    else
      render 'new'
    end
  end


  private
  def pin_params
    params.require(:pin).permit(:title, :description, :image )
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end


end





