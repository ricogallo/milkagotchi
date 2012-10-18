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
    respond_with GameAction.new(params[:id], "feed").run
  end
  
  def clean
    respond_with GameAction.new(params[:id], "clean").run
  end
  
  def play
    respond_with GameAction.new(params[:id], "play").run
  end
  
  def deliver_milk
    respond_with GameAction.new(params[:id], "deliver_milk").run
  end
  
  def destroy
    respond_with Chick.find(params[:id]).destroy
  end
end
