class QuestionsController < ApplicationController
	impressionist :actions=>[:show]
	before_action :authenticate_user!, only: [:new, :create, :edit, :update]

	def index
		@questions = Question.all.order(created_at: :desc).page(params[:page]).per(6)
	end

	def rank
		@questions = Question.find(Vote.group(:question_id).order('count(question_id) desc').pluck(:id))
		render 'index'
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
		@chart = Answer.joins(:votes).where(question_id: @question.id)
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
