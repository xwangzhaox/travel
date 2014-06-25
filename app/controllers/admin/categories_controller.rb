class Admin::CategoriesController < ApplicationController
  layout "admin"

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /admin/articles/1/edit
  def edit
    @category = Category.find(params[:id])
    @articles = Admin::Article.find_by_is_tourist_route(true)
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @category = Category.new(params[:category])
    @category.format_name = params[:category][:name].gsub(/ /, "_").downcase

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_scenic_spots_path, notice: 'Article was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    @category = Category.find(params[:id])
    @category.format_name = params[:category][:name].gsub(/ /, "_").downcase
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_scenic_spots_url, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_scenic_spots_url }
      format.json { head :no_content }
    end
  end
end
