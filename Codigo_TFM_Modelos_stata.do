clear all
set more off

************/

*log using "C:\Users\34654\Desktop\UPO_20_21\TFG\prueba_TFG.log", replace
use "EPA_muestraCompleta_varGeneradas"

*******************************Tablas estadisticas*******************************

*Mantener trabajo - tasa de empleo
tab empleado [iweight=factorel] if ciclo==187 & participa==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1					//Diferencia: quien mantiene el empleo entre los dos años


****************************** Regresiones ********************************

//Generamos variables para el modelo
	*Grupos de edad

gen edad1629 = (edad==1)
gen edad2029 = (edad==2)
gen edad3039 = (edad==3)
gen edad4049 = (edad==4)
gen edad5067 = (edad==5)

	* Para los parados 2019
gen parados19 = (participa==1 & ciclo==187)
************probit parado edad4049 edad5067 noEstudiosYEstudiosPirm educTer industa desempleo_1año larga_duracion if ciclo==187
probit paradosActivos hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==187
margins, dydx(*)
outreg2 using resultados

		**Comprobar estimacion probabilidades de modelo
qui probit paradosActivos hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==187
estat classification
lsens
lroc

	*Parados 2020
probit paradosActivos hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==191
margins, dydx(*)
		**Comprobar estimacion probabilidades de modelo
qui probit paradosActivos hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==191
estat classification
lroc

	*Parados 2020 con paro corto
gen parados1año = (parado==1 & participa==1 & desempleoMenos1año)
tab parados1año
probit parados1año hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura if ciclo==191
estat classification
lroc
margins, dydx(*)


	*Para los individuos en ERTE
probit si_ERTE hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==191
margins, dydx(*)
qui probit si_ERTE hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura desempleo_1año larga_duracion if ciclo==191
estat classification
lroc


**/--------------------------/**
//Multilogit Empleo, desempleo y ERTE
gen situacionLaboral =.
replace situacionLaboral =0 if (participa==1 & empleado==1 & si_ERTE==0)
replace situacionLaboral =1 if (participa==1 & parados1año)
replace situacionLaboral =2 if (participa==1 & si_ERTE==1)

mlogit situacionLaboral hombres edad3039 edad4049 edad5067 noEstudiosYEstudiosPirm educTer cualificacionMedia cualificacionAlta industa construccion agricultura [iweight=factorel] if ciclo==191, robust b(1) rrr


log close
