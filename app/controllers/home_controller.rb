class HomeController < ApplicationController
  def index
    @articles =
      if params[:category]
        category_id = Category.find_by(name: params[:category]).id
        Article.where(category_id: category_id).order('created_at DESC')
      else
        Article.all.order('created_at DESC')
      end
    @articles_last = Article.all.limit(4).order('created_at DESC')
    @categories = Category.all
    @tags = Tag.all
  end

  def about
  end
end
