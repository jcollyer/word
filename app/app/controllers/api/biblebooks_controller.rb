class Api::BiblebooksController < ApplicationController
  respond_to :json

  def index
    respond_with Biblebook.all
  end

  private

  def story_params
    params.require(:biblebook).permit(:title, :intro, :extended, :published_at, :author)
  end
end
