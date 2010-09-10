class HelpController < ApplicationController

  def show
    @section = sanitize(params[:section])
    @page    = sanitize(params[:page])
    
    if %w( general-questions absentee-voting vote-by-mail-process vote-by-mail ).include?(@section) ||
       (@section == 'security' && @page != 'index')
      render :template => "help/questions_page"
    else
      render :template => "help/#{@section}/#{@page}"
    end
  end

  private
  
  def sanitize(txt)
    txt.gsub(/[^a-z0-9\-]/i, '')
  end
  
end
