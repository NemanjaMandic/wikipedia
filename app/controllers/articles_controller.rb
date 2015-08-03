class ArticlesController < ApplicationController
    before_action :find_article, only: [:show]
    before_action :authenticate_user!, except: [:index, :show]
    
    def index
        if params[:category].blank?
          @clanci = Article.all.order("created_at DESC")
      else
          @category_id = Category.find_by(name: params[:category]).id
          @clanci = Article.where(category_id: @category_id).order("created_at DESC")
        end
    end
    
    def show
    end
    def new
        @article = current_user.articles.build
    end
    
    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            flash[:success] = "Uspesno si napravio neki kurac!"
            redirect_to @article 
        else
            render 'new'
        end
    end
    
    private
    
    def find_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :content, :category_id)
    end
end
