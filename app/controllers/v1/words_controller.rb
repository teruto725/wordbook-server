module V1
  class WordsController < ApplicationController

    def create
      @wordbook = Wordbook.find params[:wordbook_id]
      @word = @wordbook.words.create! english: params[:english], japanese: params[:japanese], difficulty: 0, count:0
      render json: @word, serializer: V1::WordSerializer
    rescue ActiveRecord::RecordInvalid
      render json: {error: "サーバーエラーです。もう一度やり直してください"}, status: :internal_server_error
    end

    def index
      @wordbook = Wordbook.find params[:wordbook_id]
      @words = @wordbook.words
      render json: @words, each_serializer: V1::WordSerializer
    end

    def update
      @wordbook = Wordbook.find params[:wordbook_id]
      @word = Word.find params[:id]
      render json: @word, each_serializer: V1::WordSerializer
    end

    def destroy
      @word = Word.find params[:id]
      @word.destroy
      render json: @word, serializer: V1::WordSerializer
    end

    def success
      @word=Word.find(params[:id])
      if @word.user_id == current_user.id
        count = word.count-1
        diff = word.difficulty-(2*count)
        @word.update!(difficulty: diff, count: count)
        render json: @word, serializer: V1::WordSerializer
      end
    end

    def fault
      @word=Word.find(params[:id])
      if @word.user_id == current_user.id
        count = word.count + 1
        diff = word.difficulty-(2*count)
        @word.update!(difficulty: diff, count: count)
        render json: @word, serializer: V1::WordSerializer
      end
    end

  end
end

