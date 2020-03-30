class LeasesController < ApplicationController
  
    def show
      @lease = Lease.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @lease}
      end
    end
  
    def index
      @leases = Lease.all
      respond_to do |format|
        format.html
        format.csv { send_data @leases.to_csv(['tenant'])}
      end   
    end

    def search
      @leases = Lease.search(params[:search])
      render :index
    end

    def filter
      parameters = {
        submarket: params[:submarket],
        lease_high: params[:lease_high],
        lease_low: params[:lease_low],
        lcd_high: params[:lcd_high],
        lcd_low: params[:lcd_low],
        lxd_high: params[:lxd_high],
        lxd_low: params[:lxd_low] 
      }
      @leases = Lease.filter(parameters)
      render :index 
    end

    def import
      Lease.import(params[:file])
      # need to figure out the right format for import
      # need to handle failures
      #need to figure out how to make sure leases relate to properties
      redirect_to root_url, notice: 'Leases Uploaded successfully'
    end
  
    def new
      @lease = Lease.new
      @properties = Property.all
    end
  
    def create
      @property = Property.find(params[:lease][:property_id])

      params[:lease][:landlord_broker_company] = @property[:landlord_broker_company]
      params[:lease][:bldg_owner] = @property[:bldg_owner]
      params[:lease][:property_manager] = @property[:property_manager]
      params[:lease][:quoted_rate] = @property[:quoted_rate]
      params[:lease][:nnn] = @property[:nnn]
      params[:lease][:electric] = @property[:electric]
    
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
      params.require(:lease).permit(:tenant, :lease_size, :suite, :term, :sign_date, :commencement_date, :expiration_date, :lease_type, :fy_rent, :rent_type, :effective_rent, :escalation, :free_rent, :ti_psf, :transaction_type, :tenant_broker_company, :base_year, :landlord_broker_company, :bldg_owner, :property_manager, :quoted_rate, :nnn, :electric, :property_id)
    end
  
  end