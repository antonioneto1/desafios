Rails.application.routes.draw do
	root to: 'miojos#calculadora_new'
	get '/miojos/calculadora', to: 'miojos#calculadora_new'
	get '/distancias/calculadora_de_distancias', to: 'distancias#calculadora_de_distancias_new'
	post '/miojos/calculadora', to: 'miojos#calculadora'
	post '/distancias/calculadora_de_distancias', to: 'distancias#calculadora_de_distancias'
end
