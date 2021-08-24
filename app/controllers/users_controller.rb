class UsersController < ApplicationController
    # returns an array of error messages in the body
    # returns a 422 (Unprocessable Entity) HTTP status code
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # returns an array of error messages in the body
    # returns a 422 unprocessable entity response
    # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create
        # creates a new user
        # saves the password as password_digest to allow authentication
        # saves the user id in the session
        # returns the user as JSON
        # returns a 201 (Created) HTTP status code

        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # returns an array of error messages in the body
            # returns a 422 unprocessable entity response
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            #unprocessable_entity returns 422
        end

    end

    def show
        # returns the first user when the first user is logged in
        # returns the second user when the second user is logged in
        # returns a 401 unauthorized response when no user is logged in
        
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "Unauthorized user" }, status: :unauthorized
        end

    end


    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    # def record_not_found
    #     render json: { error: "User not found" }, status: :not_found
    # end

    # def record_invalid
    #     render json: { error: "User invalid" }, status: :unprocessable_entity
    # end
end
