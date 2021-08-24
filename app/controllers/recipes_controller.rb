class RecipesController < ApplicationController


    def show

        # returns an array of error messages in the body
        # returns a 401 (Unauthorized) HTTP status code

        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
        
        # returns an array of recipes with their associated users
        user = User.find_by(id: session[:user_id])
        # you need to find the user in the session and then assciate them with the recipes
        render json: user.recipes, include: :user #include: :user - includes the associated user

    end

    def create

        # creates a new recipe in the database
        # returns the new recipe along with its associated user
        # returns a 201 (Created) HTTP status code
        
        # you make a new recipe then associated with the current user in the session
        recipe = Recipe.new(recipe_params)
        user = User.find_by(id: session[:user_id])
        recipe.user = user

        if recipe.save
            render json: recipe, include: :user, status: :created #include: :user - includes the associated user
        elsif !user # !user is saying if the user comes back false which ones if there is no user
            # returns an array of error messages in the body
            # returns a 401 (Unauthorized) HTTP status code 
            render json: { errors: recipe.errors.full_messages }, status: :unauthorized
        else
            # does not create a new recipe in the database
            # returns an array of validation error messsages
            # returns a 422 (Unprocessable Entity) HTTP status code
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end



end
