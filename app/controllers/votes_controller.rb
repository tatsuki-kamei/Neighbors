class VotesController < ApplicationController
	def create
    @question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    vote = current_user.votes.new(question_id: @question.id, answer_id: answer.id)
    user_vote = Vote.find_by(user_id: current_user.id, question_id: @question.id)
    if  user_vote.present?
      user_vote.update(answer_id: answer.id)
    else
      vote.save
    end
    redirect_to question_path(@question)
  end

  def destroy
    vote = Vote.find(params[:id])
    @question = vote.question
    vote.destroy
    redirect_to question_path(@question)
  end

end
