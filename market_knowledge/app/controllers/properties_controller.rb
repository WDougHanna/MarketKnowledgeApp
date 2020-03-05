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

    def import
      Property.import(params[:file])
      redirect_to root_url, notice: 'Properties Uploaded successfully'
    end
  
    def new
      @property = Property.new
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