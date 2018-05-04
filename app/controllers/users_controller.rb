class UsersController < Clearance::UsersController

    def show
        @user = current_user
    end

    def new
        @user = user_from_params
        render template: "users/new"
    end

    def create
        @user = user_from_params
        if @user.save
            sign_in @user
            redirect_back_or url_after_create
        else
            render template: "users/new"
        end
    end

    def edit
        @user = current_user
      end
    
     def update
        @user = current_user
       if @user.update_attributes(user_params)
        redirect_back_or users_show_path
      else
        render 'edit'
      end
    end

    def reservations
        @user = current_user
        @reservation = Reservation.all

    end

    private



    def user_from_params
        user_params = params[:user] || Hash.new
        profile_image = user_params.delete(:profile_image)
        remote_profile_image_url= user_params.delete(remote_profile_image_url)
        email = user_params.delete(:email)
        password = user_params.delete(:password)
        first_name = user_params.delete(:first_name)
        last_name = user_params.delete(:last_name)
        gender = user_params.delete(:gender)
        phone = user_params.delete(:phone)
        country = user_params.delete(:country)
        birthdate = user_params.delete(:birthdate)
      
        Clearance.configuration.user_model.new(user_params).tap do |user|
            user.profile_image = profile_image
            user.remote_profile_image_url = remote_profile_image_url
            user.email = email
            user.password = password
            user.first_name = first_name
            user.last_name = last_name
            user.gender = gender
            user.phone = phone
            user.country = country
            user.birthdate = birthdate
        end
    end

    def user_params
        params.require(:user).permit(:profile_image, :remote_profile_image_url, :email, :password, :first_name, :last_name, :gender, :phone, :country, :birthdate)
       end

      def permit_params
        params.require(:user).permit(:profile_image, :remote_profile_image_url, :password, :email, :first_name, :last_name, :gender, :phone, :country, :birthdate)
      end 

end