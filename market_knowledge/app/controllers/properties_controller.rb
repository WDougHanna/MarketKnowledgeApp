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
    end
  
    def new
      @property = Property.new
    end
  
    def create
      @property = Property.new(property_params)
      if @property.save
      render json: @property, status: 201
      else
        render :new
      end
    end
  
    def edit
  
    end
  
    def update
      if @property.update(property_params)
        redirect_to @property
      else
        render :edit
      end
    end
  
    def destroy
      @property.destroy
      redirect_to properties_path
    end
  
  private
  
    def property_params
      params.require(:property) #waiting on scema confirmation
    end
  
  end