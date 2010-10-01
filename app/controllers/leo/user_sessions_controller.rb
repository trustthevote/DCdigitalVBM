class Leo::UserSessionsController < Leo::BaseController
  before_filter :require_no_user, :only => [ :new, :create ]
  before_filter :require_user,    :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      LogRecord::LoggedIn.create(:reviewer => @user_session.record)

      flash[:notice] = "Login successful!"
      redirect_back_or_default leo_review_url
    else
      render :action => :new
    end
  end
  
  def destroy
    LogRecord::LoggedOut.create(:reviewer => current_user)

    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end
end