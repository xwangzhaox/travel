class Admin::ArticlesController < ApplicationController
  layout "admin"

  ['great_wall'].each do |menu|
    define_method(menu) do
      @page_title = menu.gsub(/\_/, " ").upcase
      redirect_to :action => "edit", :id => Admin::Article.find_by_title(menu).id
    end
  end

  Category.all.map(&:name).each do |category|
    define_method(category.gsub(/ /, "_").downcase) do
      @category = Category.find_by_name(category)
      render :template => "admin/articles/category", :locals => {:articles => Admin::Article.all }
    end
  end

  # GET /admin/articles
  # GET /admin/articles.json  
  def index
    except_articles = ['great_wall']
    @admin_articles = Admin::Article.all.select{|x|!except_articles.include?(x.title)}
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_articles }
    end
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.json
  def show
    @admin_article = Admin::Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @admin_article = Admin::Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/1/edit
  def edit
    @admin_article = Admin::Article.find(params[:id])
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @admin_article = Admin::Article.new(params[:admin_article])

    respond_to do |format|
      if @admin_article.save
        format.html { redirect_to @admin_article, notice: 'Article was successfully created.' }
        format.json { render json: @admin_article, status: :created, location: @admin_article }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    @admin_article = Admin::Article.find(params[:id])

    respond_to do |format|
      if @admin_article.update_attributes(params[:admin_article])
        format.html { redirect_to @admin_article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @admin_article = Admin::Article.find(params[:id])
    @admin_article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :no_content }
    end
  end

  def update_category
    category_title = params[:category].gsub(/_/, " ").upcase
    Category.find_by_name(category_title).article_ids = params[:articles].split(",").collect{|x|x.to_i}
    render :json => {
      :connect_success => true
    }
  end
end