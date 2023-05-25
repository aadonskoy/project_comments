class CommentsController < ApplicationController
  def create
    @new_comment = Comment.new(comment_params) do |comment|
      comment.project = project
    end

    if @new_comment.save
      redirect_to project, notice: "Comment was successfully added"
    else
      render project, status: :unprocessable_entity
    end
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :username)
  end
end
