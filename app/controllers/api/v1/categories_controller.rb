module Api::V1
  class CategoriesController < ApplicationController
    before_action :get_category, only: %i[show update destroy]

    def index
      render json: Category.where(parent_id: 0), each_serializer: Categories::CategoriesSerializer
    end

    def show
      if !@category.nil?
        render json: @category, serializer: Categories::CategoriesSerializer
      else
        render json: { message: 'Cannot found!', status: 404 }
      end
    end

    def create
      category = Categories.new(category_params)
      if category.save
        render json: { message: 'Success!', status: 200 }
      else
        render json: { message: 'False!', status: 409 }
      end
    end

    def update
      message = if @category
        if @category.update(category_params)
          { message: 'Update successed!', status: 202 }
        else
          { message: 'Update failt!', status: 409 }
        end
      else
        { message: 'Not found user!', status: 404 }
      end
      message['errors'] = @category.errors.full_messages
      render json: message
    end

    def destroy
      if @category.destroy
        render json: { message: 'Success!', status: 200 }
      else
        render json: { message: 'False!', status: 409 }
      end
    end

    private

    def get_category
      @category = Category.find_by slug: params[:id]
    end

    def category_params
      params.permit params[:name]
    end
  end
end