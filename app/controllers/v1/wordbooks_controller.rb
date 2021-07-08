module V1
  class WordbooksController < ApplicationController

    def create
      @user = current_user
      @wordbook = @user.wordbooks.create! name: params[:name], before_word_id:0
      logger.debug @wordbook
      render json: @wordbook, serializer: V1::WordbookSerializer
    end

    def index
      @user = current_user
      @wordbooks = @user.wordbooks
      render json: @wordbooks, each_serializer: V1::WordbookSerializer
    end

    def destroy
      @wordbook = Wordbook.find params[:id]
      @wordbook.destroy!
      render json: @wordbook, serializer: V1::WordbookSerializer
    end

    #最もdiffの高い単語を返す
    def most_diff_word
      @wordbook = Wordbook.find params[:id]
      @words = @wordbook.words.order(:difficulty).limit(1)
      if @words.length == 1
        render json: @words[0], serializer: V1::WordbookSerializer
      else
        render json: {error: "まず単語を登録してください"}
      end
    rescue ActiveRecord::RecordNotFound
      render json: {error: "まず単語を登録してください"}, status: :not_found
    end

  end
end
