class PagesController < ApplicationController

  def front
  end

  def overview
    self.voting_type = params[:voting_type] if params[:voting_type]
  end

end
