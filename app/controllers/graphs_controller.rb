class GraphsController < ApplicationController
    before_filter :load_graph, :except => [:index, :new, :create]

    def index
        @graphs = Graph.all
    end

    def show
        respond_to do |format|
            format.html {
                if request.xhr?
                    render 'graph', :layout => false
                end
            }
            format.json { render_for_api :everything, :json => @graph }
        end
    end

    def new
        @graph = Graph.new
    end

    def create
        @graph = Graph.new(params[:graph])
        @graph.import_data_from_attachment!
        redirect_to graph_path(@graph)
    end

    def edit
    end

    def update
        @graph.update_attributes(params[:graph])
        @graph.update_data_from_attachment!
        redirect_to graph_path(@graph)
    end

    def destroy
        @graph.destroy
    end

    def load_graph
        @graph = Graph.find(params[:id])
    end
end