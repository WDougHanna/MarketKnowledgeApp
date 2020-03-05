class LeasesController < ApplicationController
  
    def show
      @lease = Lease.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @lease}
      end
    end
  
    def index
      @leases = Lease.search(params[:search])
      respond_to do |format|
        format.html
        format.csv { send_data @leases.to_csv(['tenant'])}
      end   
    end

    def import
      Lease.import(params[:file])
      redirect_to root_url, notice: 'Leases Uploaded successfully'
    end
  
    def new
      @lease = Lease.new
      @properties = Property.all
    end
  
    def create
      @lease = Lease.new(lease_params)
      if @lease.save
        redirect_to @lease
      else
        @properties = Property.all
        render :new
      end
    end
  
    def edit
      @lease = Lease.find(params[:id])
      @properties = Property.all
    end
  
    def update
      @lease = Lease.find(params[:id])
      if @lease.update(lease_params)
        redirect_to @lease
      else
        render :edit
      end
    end
  
    def destroy
      @lease = Lease.find(params[:id])
      @lease.destroy
      redirect_to leases_path
    end
  
    private
  
    def lease_params
      params.require(:lease).permit! #waiting to confirm schema
    end
  
  end