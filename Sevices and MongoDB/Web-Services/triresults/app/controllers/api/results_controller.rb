module Api
    class ResultsController < ApplicationController
        protect_from_forgery with: :null_session

        def index
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:race_id]}/results"
            else
            end
        end
        def show
            if !request.accept || request.accept == "*/*"
            render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
            end
        end
        def update
        end
    end
end