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
                # render plain: "#{params[:race][:name]}", status: :ok
                render plain: :nothing, status: :ok
            else
                #real implementation
            end
        end
        def update
        end
        def destroy
        end
    end
end