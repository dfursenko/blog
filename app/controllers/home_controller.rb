class HomeController < ApplicationController
  def index
    # @categories = Category.all
    # @tags = Tag.all
    @articles = Article.all.order('created_at DESC')
  end

  def about

  end
end
