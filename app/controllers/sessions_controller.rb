class SessionsController < ApplicationController


    def create
        
        user =  User.find_by(username: params[:username])
        if user&.authenticate((params[:password]))
            # returns the logged in user
            # sets the user ID in the session

            session[:user_id] = user.id
            render json: user, status: :created
        else
            # does not set the user ID in the session
            # returns an array of error messages in the body
            # returns a 401 (Unauthorized) status code

            render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end

    def destroy
        # returns no content
        # deletes the user ID from the session
        
        
        if session[:user_id]
        session.delete :user_id
        head :no_content
        else
            # returns an array of error messages in the body
            # returns a 401 (Unauthorized) status code
            render json: { errors: ["User not found"] }, status: :unauthorized
        end
    end


end
