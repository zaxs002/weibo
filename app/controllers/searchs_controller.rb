class SearchsController < ApplicationController
  def index
    @a = params[:type]
    if @a=="micropost"
      @rs = Micropost.search(params[:search])
      respond_to do |f|
        f.html { render "index" }
        f.js
      end
    elsif @a=="user"
      @rs = User.search(params[:search])
      respond_to do |f|
        f.html
        f.js { render "j"}
      end
    else

    end
  end
end