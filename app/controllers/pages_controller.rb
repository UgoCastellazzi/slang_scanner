class PagesController < ApplicationController
  def home
    @words = Word.all
    if params[:word]
      @keyword = params[:word].downcase
      @words = Word.all.where("lower(name) LIKE :word", word: "%#{@keyword}%")
      # @words = @words.select { |word| word.name.start_with?(params[:word]) }
    end
  end
end
