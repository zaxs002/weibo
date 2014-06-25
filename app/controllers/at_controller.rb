class AtController < ApplicationController
  def index
    @a = User.search("v")
    rs = ""
    @a.each do |x|
      rs +=x.name+"-"
    end
    render inline: rs
  end
end