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
      @wordbook = Wordbook.find params[:wordbook_id]
      @word=Word.find(params[:word_id])
      if @wordbook.user_id == current_user.id
        count = @word.count-1
        diff = @word.difficulty-(2*count)
        logger.debug(diff)
        @word.update!(difficulty: diff, count: count)
        @next_word = @wordbook.words.where.not(id: @word.id).order(:difficulty).limit(1)

        render json: @next_word[0], serializer: V1::WordSerializer
      end
      #rescue
      #render json: {error: "単語は２つ以上登録してください"}, status: :not_found
    end

    def fault
      @wordbook = Wordbook.find params[:wordbook_id]
      @word=Word.find(params[:word_id])
      if @wordbook.user_id == current_user.id
        count = @word.count + 1
        diff = @word.difficulty-(2*count)
        @word.update!(difficulty: diff, count: count)
        @next_word = @wordbook.words.where.not(id: @word.id).order(:difficulty).limit(1)
        render json: @next_word[0], serializer: V1::WordSerializer
      end
    rescue
      render json: {error: "単語は２つ以上登録してください"}, status: :not_found
    end

  end
end

