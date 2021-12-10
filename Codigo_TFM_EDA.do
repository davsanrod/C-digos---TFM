clear all
set more off

************/

use "EPA_muestraCompleta_varGeneradas"

*******************************--EDA--*******************************

sum 
des

*Tasa de participacion
tab participa [iweight=factorel] if ciclo==187
tab participa [iweight=factorel] if ciclo==191

*Mantener trabajo - tasa de empleo
tab empleado [iweight=factorel] if ciclo==187 & participa==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1					//Diferencia: quien mantiene el empleo entre los dos años

//Diferencia por genero y años
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & hombres==1		
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & hombres==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & mujeres==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & mujeres==1
tab participa [iweight=factorel] if ciclo==187 & hombres==1		
tab participa [iweight=factorel] if ciclo==191 & hombres==1
tab participa [iweight=factorel] if ciclo==187 & mujeres==1
tab participa [iweight=factorel] if ciclo==191 & mujeres==1

tab empleado [iweight=factorel] if ciclo==187 & participa==1 &edad==1		//Diferencia por grupos de edad y por años
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & edad==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & edad==2
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & edad==2
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & edad==3
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & edad==3
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & edad==4
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & edad==4
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & edad==5
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & edad==5

tab empleado [iweight=factorel] if ciclo==187 & participa==1 & noEstudios==1	//Diferencia por estudios
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & noEstudios==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & educPrim==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & educPrim==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & educSec==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & educSec==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & educTer==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & educTer==1

tab empleado [iweight=factorel] if ciclo==187 & participa==1 & cualificacionBaja==1		//Diferencia por la cualificacion laboral
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & cualificacionBaja==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & cualificacionMedia==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & cualificacionMedia==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & cualificacionAlta==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & cualificacionAlta==1

tab empleado [iweight=factorel] if ciclo==187 & participa==1 & agricultura==1	//Diferencia por sector
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & agricultura==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & industa==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & industa==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & construccion==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & construccion==1
tab empleado [iweight=factorel] if ciclo==187 & participa==1 & servicios==1
tab empleado [iweight=factorel] if ciclo==191 & participa==1 & servicios==1

tab contratoIndefinido [iweight=factorel] if ciclo==187 & participa==1  		//Diferencia por tipo de contrato
tab contratoIndefinido [iweight=factorel] if ciclo==191 & participa==1
tab contratoTemporal [iweight=factorel] if ciclo==187 & participa==1
tab contratoTemporal [iweight=factorel] if ciclo==191 & participa==1
