class HomeController < ApplicationController
  def index
    @articles =
      if params[:category]
        Category.find_by(name: params[:category]).articles
      elsif params[:tag]
        Tag.find_by(name: params[:tag]).articles
      else
        Article.all.order('created_at DESC')
      end
  end

  def about
  end
end
