class UsersController < ApplicationController
  AVAILABLE_SETTING_ITEMS = %w(account password profile)

  def index
    @users_by_grade = User.all.group_by(&:grade)
    @user_count_by_grade = User.group(:grade).count
    @active_user_count = @user_count_by_grade.inject(0) do |sum, (grade, count)|
      (1..4).include?(grade) ? sum + count : sum
    end
  end

  def show
    @user = User.find_by_username(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  end

  def edit
    redirect_to root_url unless @login_user
    unless AVAILABLE_SETTING_ITEMS.include?(params[:item])
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def update
    redirect_to root_url unless @login_user
  end

  def destroy
    redirect_to root_url unless @login_user
  end
end
