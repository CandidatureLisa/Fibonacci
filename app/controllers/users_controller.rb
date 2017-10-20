class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    if @user.save
      sign_in @user

      redirect_back_or url_after_create
    else
      render :new
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
end
