class ChicksController < ApplicationController
  respond_to :json
  
  def index
    sleep 2
    respond_with Chick.all
  end
  
  def show
    respond_with Chick.find(params[:id])
  end
  
  def create
    sleep 1
    respond_with Chick.create(params[:chick])
  end
  
  def update
    respond_with Chick.update(params[:id], params[:chick])
  end
  
  def destroy
    respond_with Chick.find(params[:id]).destroy
  end
end
