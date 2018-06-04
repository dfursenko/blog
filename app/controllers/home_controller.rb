class HomeController < ApplicationController
  def index
    @articles =
      if params[:category]
        Category.find_by(name: params[:category]).articles.order('created_at DESC')
      elsif params[:tag]
        Tag.find_by(name: params[:tag]).articles.order('created_at DESC')
      else
        # Article.all.order('created_at DESC')
        Article.includes(:user).page(params[:page]).per(3).order('created_at DESC')
      end
  end

  def about
  end
end
