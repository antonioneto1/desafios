class DistanciasController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def calculadora_de_distancias_new
    @distancia = Distancia.new

    respond_to do |format|
      format.html { render :calculadora_de_distancias }
    end
  end

  def calculadora_de_distancias
    @distancia = Distancia.new(distancia_params)

    begin
      distancia_params.each do |d|  
        raise "É preciso especificar Graus (º), minutos (') e segundos (''), para Calcular." if !d[1] && !d[1].include?("º") && !d[1].include?("'") && !d[1].include?("''")
      end
      @distancia.calculadora_de_distancias(distancia_params[:lagitude_1], 
        distancia_params[:lagitude_2],
        distancia_params[:longitude_1],
        distancia_params[:longitude_2]);
    rescue StandardError => e
      flash[:error] = e.message
    end
    
    respond_to do |format|
      format.json { render json: @distancia.to_json, layout: false  }
      format.html
    end
  end

  private
    def distancia_params
      params.require(:calculadora_de_distancias).permit(:lagitude_1, :lagitude_2, :longitude_1, :longitude_2)
    end
end