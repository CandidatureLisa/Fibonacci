class UsersController < Clearance::UsersController
  before_action :set_user, only: [:step_sign_up, :update]

  def create
    @user = user_from_params
    @user.fill_general_informations

    if @user.save
      redirect_to step_sign_up_user_path(@user)
    else
      render :new
    end
  end

  def step_sign_up
  end

  def update
    @user.fill_technical_informations

    if @user.update(user_params)
      sign_in @user

      redirect_back_or url_after_create
    else
      render :step_sign_up
    end
  end

  private

    def user_params
      return Hash.new unless params[:user]
      params.require(:user).permit(
        :email,
        :password,
        :first_name,
        :last_name,
        :street_number,
        :street_name,
        :zip_code,
        :city,
        :situation,
        :pdl
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
end
