class ChicksController < ApplicationController
  respond_to :json
  
  def index
    respond_with Chick.all
  end
  
  def show
    respond_with Chick.find(params[:id])
  end
  
  def create
    respond_with Chick.create(params[:chick])
  end
  
  def feed
    respond_with Chick.find(params[:id]).feed
  end
  
  def clean
    respond_with Chick.find(params[:id]).clean
  end
  
  def play
    respond_with Chick.find(params[:id]).play
  end
  
  def deliver_milk
    respond_with Chick.find(params[:id]).deliver_milk
  end
  
  def destroy
    respond_with Chick.find(params[:id]).destroy
  end
end
