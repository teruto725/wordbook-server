module V1
  class WordsController < ApplicationController
    # POST
    # Create an user
    def create
      user = current_user
      word = user.words.create! english: params[:english], japanese: params[:japanese], difficulty: 0
      render json: word, serializer: V1::WordSerializer
    rescue ActiveRecord::RecordInvalid
      render json: {error: "サーバーエラーです。もう一度やり直してください"}, status: :internal_server_error
    end

    def index
      user = current_user
      words = user.words
      render json: words, each_serializer: V1::WordSerializer
    end

    def update
      word= Word.find(params[:id])
      if word.user_id == current_user.id
        word.update!(english: params[:english], japanese:params[:japanese], difficulty: params[:difficulty])
        render json: word, serializer: V1::WordSerializer
      else
        render json: {error: "存在しない単語です"}, status: :not_found
      end
    end

    def destroy
      word = Word.find(params[:id])
      if word.user_id == current_user.id
        render json: word, serializer: V1::WordSerializer
      else
        render json: {error: "存在しない単語です"}, status: :not_found
      end
    end

    #最もdiffの高い単語を返す
    def most_diff_word
      user = current_user
      words = user.words.order(:difficulty).limit(1)
      if words.length == 1
        render json: words[0], serializer: V1::WordSerializer
      else
        render json: {error: "まず単語を登録してください"}
      end
    end
  end
end

