class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])

    #if !params["figure"]["title_ids"].empty?
    #  @figure.titles << params["figure"]["title_ids"].collect do |title_id|
    #    Title.find_by(id: title_id)
    #  end
    #end

    @figure.title_ids = params["figure"]["title_ids"]

    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    #if !params["figure"]["landmark_ids"].empty?
      #@figure.landmarks << #params["figure"]["landmark_ids"].collect do |landmark_id|
    #    Landmark.find_by(id: landmark_id)
    #  end
    #end

    @figure.landmark_ids = params["figure"]["landmark_ids"]

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])

    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    #if !params["figure"]["landmark_ids"].empty?
      #@figure.landmarks << #params["figure"]["landmark_ids"].collect do |landmark_id|
    #    Landmark.find_by(id: landmark_id)
    #  end
    #end

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
