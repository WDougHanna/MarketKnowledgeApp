class PropertiesController < ApplicationController
  
    def show
      @property = Property.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @property}
      end
    end
  
    def index
      @properties = Property.all
      respond_to do |format|
        format.html
        format.csv { send_data @properties.to_csv(['property_name'])}
      end   
    end

    def search
      @properties = Property.search(params[:search])
      render :index
    end

    def filter
      @properties = Property.filter_sub(params[:property][:submarket])
      render :index 
    end

    def import
      Property.import(params[:file])
      # need to figure out the right format for import
      # need to handle failures
      redirect_to root_url, notice: 'Properties Uploaded successfully'
    end
  
    def new
      @property = Property.new
      @submarkets = Submarket.all
    end
  
    def create
      @property = Property.new(property_params)
      if @property.save
      render :show
      else
        render :new
      end
    end
  
    def edit
      @property = Property.find(params[:id])
    end
  
    def update
      @property = Property.find(params[:id])
      if @property.update(property_params)
        redirect_to @property
      else
        render :edit
      end
    end
  
    def destroy
      @property = Property.find(params[:id])
      @property.destroy
      redirect_to properties_path
    end
  
  private
  
    def property_params
      params.require(:property).permit! #waiting on schema confirmation
    end
  
  end