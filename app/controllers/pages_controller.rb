class PagesController < ApplicationController
  def home
    @words = Word.all
    if params[:word]
      @words = @words.select { |word| word.name.start_with?(params[:word]) }
    end
  end
end
