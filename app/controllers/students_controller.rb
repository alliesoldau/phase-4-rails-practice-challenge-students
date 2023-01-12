class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    #GET all
    def index
        students = Student.all
        render json: students, each_serializer: StudentSerializer, status: :ok 
    end

    #GET one
    def show
        student = find_student
        render json: student, serializer: StudentSerializer, status: :ok
    end

    #POST
    def create
        student = Student.create!(student_params)
        render json: student, serializer: StudentSerializer, status: :created
    end

    #PATCH
    def update
        student = find_student
        student.update(student_params)
        render json: student, serializer: StudentSerializer, status: :accepted
    end

    #DELETE
    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_invalid_response (e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

end
