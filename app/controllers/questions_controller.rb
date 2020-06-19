class QuestionsController < ApplicationController

	def index
		@questions = Question.all.order(created_at: :desc)
	end

	def new
		@question = Question.new
		@answers = @question.answers.build
	end

	def create
		question = Question.new(question_params)
		question.save
		redirect_to question_path(question)
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers
	end

	def edit
		@question = Question.find(params[:id])
		@answer = @question.answers
	end

	def update
		question = Question.find(params[:id])
		question.update(question_params)
	end

	private
	def question_params
  		params.require(:question).permit(:title, :text, answers_attributes:[:id,:question_id,:text, :_destroy])
  	end
end
