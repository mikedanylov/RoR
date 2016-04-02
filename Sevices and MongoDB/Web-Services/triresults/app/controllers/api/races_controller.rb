module Api
    class RacesController < ApplicationController
        protect_from_forgery with: :null_session

        def index
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
            else
                #real implementation ...
            end
        end
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:id]}"
            else
                #real implementation ...
            end
        end
        def create
            if !request.accept || request.accept == "*/*"
                render plain: "#{params[:race][:name]}", status: :ok
            else
                @race = Race.new(race_params)
                if @race.save
                    render plain: race_params[:name], status: :created
                else
                    render json: @race.errors
                end
            end
        end
        def update
        end
        def destroy
        end
    end
end