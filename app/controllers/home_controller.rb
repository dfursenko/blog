class HomeController < ApplicationController
  def index
    @technologies = Technology.all.order('rank ASC')
  end
end
