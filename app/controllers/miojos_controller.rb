class MiojosController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def calculadora_new
    @miojo = Miojo.new

    respond_to do |format|
      format.html { render :calculadora }
    end
  end

  def calculadora
    @miojo = Miojo.new(miojo_params[:tempo_de_preparo], 
                      miojo_params[:ampulheta_1], 
                      miojo_params[:ampulheta_2])

    begin
      @miojo.calculadora();
    rescue StandardError => e
      flash[:error] = e.message
    end
    
    respond_to do |format|
      format.json { render json: @miojo.to_json, layout: false  }
      format.html
    end
  end

  private
    def miojo_params
      params.require(:calculadora).permit(:tempo_de_preparo, :ampulheta_1, :ampulheta_2)
    end
end