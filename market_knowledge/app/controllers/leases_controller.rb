class LeasesController < ApplicationController
  
    def show
      @lease = lease.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @lease}
      end
    end
  
    def index
      @leases = lease.all
    end
  
    def new
      @lease = Lease.new
      @properties = Property.all
    end
  
    def create
      @lease = lease.new(lease_params)
      if @lease.save
        redirect_to @lease
      else
        @properties = Property.all
        render :new
      end
    end
  
    def edit
  
    end
  
    def update
      if @lease.update(lease_params)
        redirect_to @lease
      else
        render :edit
      end
    end
  
    def destroy
      @lease.destroy
      redirect_to leases_path
    end
  
    private
  
    def lease_params
      params.require(:lease) #waiting to confirm schema
    end
  
  end