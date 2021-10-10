class Distancia
  include ActiveModel::Model

  attr_accessor :lagitude_1, :lagitude_2, :longitude_1, :longitude_2, :comprimento


  def calculadora_de_distancias lagitude_1, lagitude_2, longitude_1, longitude_2
    dla = self.conversor(lagitude_1, lagitude_2)
    dlo = self.conversor(longitude_1, longitude_2)
    raiz = dla**2 + dlo**2
    self.comprimento =  Math.sqrt(raiz).round(1)
  end


  def conversor valor_1, valor_2 
    graus = ((valor_1.split("º")[0].gsub(",",".").to_f) - (valor_2.split("º")[0].gsub(",",".").to_f))
    minutos = (valor_1.split("º")[1].split("'")[0].gsub(",",".").to_f) - (valor_2.split("º")[1].split("'")[0].gsub(",",".").to_f)
    segundos = (valor_1.split("º")[1].split("'")[1].gsub(",",".").to_f) - (valor_2.split("º")[1].split("'")[1].gsub(",",".").to_f)

    distancia = (((graus * 60) + minutos + (segundos / 60))  * 1.852) * 1000
    val_convertido = distancia.round(1)
    return  val_convertido
  end
end