class InstructorsController < ApplicationController
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
        #GET all
        def index
            instructors = Instructor.all
            render json: instructors, each_serializer: InstructorSerializer, status: :ok 
        end
    
        #GET one
        def show
            instructor = find_instructor
            render json: instructor, serializer: InstructorSerializer, status: :ok
        end
    
        #POST
        def create
            instructor = Instructor.create!(instructor_params)
            render json: instructor, status: :created
        end
    
        #PATCH
        def update
            instructor = find_instructor
            instructor.update(instructor_params)
            render json: instructor, serializer: InstructorSerializer, status: :accepted
        end
    
        #DELETE
        def destroy
            instructor = find_instructor
            instructor.destroy
            head :no_content
        end
    
        private
    
        def find_instructor
            Instructor.find(params[:id])
        end
    
        def render_not_found_response
            render json: { error: "Instructor not found" }, status: :not_found
        end
    
        def render_invalid_response (e)
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        def instructor_params
            params.permit(:name)
        end
end
