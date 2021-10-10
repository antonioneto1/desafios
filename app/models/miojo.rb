class Miojo
  include ActiveModel::Model
  require 'timeout'

  attr_accessor :tempo_de_preparo, :ampulheta_1, :ampulheta_2, :resultado

  def initialize tempo_de_preparo = nil, ampulheta_1 = nil, ampulheta_2 = nil
    self.tempo_de_preparo = tempo_de_preparo
    self.ampulheta_1 = ampulheta_1 
    self.ampulheta_2 = ampulheta_2
  end

  def calculadora
    return self.resultado = tempo_de_preparo if [ampulheta_1, ampulheta_2].include?(tempo_de_preparo)
    tempo_das_ampulhetas =[ampulheta_1.to_i, ampulheta_2.to_i].minmax
    tempo_das_ampulhetas_sum = tempo_das_ampulhetas.clone
    
    begin
      Timeout.timeout(5) do
        while (tempo_das_ampulhetas_sum.max - tempo_das_ampulhetas_sum.min) != tempo_de_preparo.to_i do
          if (tempo_das_ampulhetas_sum.first < tempo_das_ampulhetas_sum.last)
            tempo_das_ampulhetas_sum[0] = tempo_das_ampulhetas_sum.first + tempo_das_ampulhetas.first
          elsif (tempo_das_ampulhetas_sum.first > tempo_das_ampulhetas_sum.last)
            tempo_das_ampulhetas_sum[1] = tempo_das_ampulhetas_sum.last + tempo_das_ampulhetas.last
          else
            if(tempo_de_preparo.to_i % tempo_das_ampulhetas.min == 0 ||
               tempo_de_preparo.to_i % tempo_das_ampulhetas.max == 0)
              return self.resultado = tempo_de_preparo.to_i
            end

            raise "Não é possível calcular o tempo de preparo com as ampulhetas informadas."
          end

					if(tempo_das_ampulhetas_sum.min == tempo_de_preparo.to_i)
            return self.resultado =  tempo_das_ampulhetas_sum.min
          end

        end
      end
    rescue Timeout::Error
      raise "Tempo de processamento excedido."
    end

    self.resultado = tempo_das_ampulhetas_sum.max
  end
end