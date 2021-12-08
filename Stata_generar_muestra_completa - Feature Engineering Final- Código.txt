clear all
set more off

**************		Tratar base de datos
		
//Lectura y convertir a csv

cd "C:\Users\34654\Desktop\Big_Data\Master\TFM\microdatosEPA_md"

	//2010
infile using "dic_epa.dct", using (md_EPA_2010T2.txt)																		
save "EPA_2010", replace
clear all

	//2011
infile using "dic_epa.dct", using (md_EPA_2011T2.txt)
save "EPA_2011", replace
clear all

	//2012
infile using "dic_epa.dct", using (md_EPA_2012T2.txt)
save "EPA_2012", replace
clear all

	//2013
infile using "dic_epa.dct", using (md_EPA_2013T2.txt)
save "EPA_2013", replace
clear all

	//2014
infile using "dic_epa.dct", using (md_EPA_2014T2.txt)
save "EPA_2014", replace
clear all

	//2015
infile using "dic_epa.dct", using (md_EPA_2015T2.txt)
save "EPA_2015", replace
clear all

	//2016
infile using "dic_epa.dct", using (md_EPA_2016T2.txt)
save "EPA_2016", replace
clear all

	//2017
infile using "dic_epa.dct", using (md_EPA_2017T2.txt)
save "EPA_2017", replace
clear all

	//2018
infile using "dic_epa.dct", using (md_EPA_2018T2.txt)
save "EPA_2018", replace
clear all

	//2019
infile using "dic_epa.dct", using (md_EPA_2019T2.txt)
save "EPA_2019", replace
clear all

	//2020
infile using "dic_epa.dct", using (md_EPA_2020T2.txt)
save "EPA_2020", replace
clear 

	//Merge muestra completa
use "EPA_2010", clear
append using EPA_2011
append using EPA_2012
append using EPA_2013
append using EPA_2014
append using EPA_2015
append using EPA_2016
append using EPA_2017
append using EPA_2018
append using EPA_2019
append using EPA_2020

*use "EPA_muestraCompleta_VFstata", replace
*use "EPA_muestraCompleta_VFstata"

**********FEATURE ENGINEERING**************

**VARIABLES TARGET**
	*Clasificación por "situación laboral"
gen empleado=(aoi<5)
gen parado = (aoi ==5 | aoi==6)
gen participa = (aoi<=6)
gen inactivo = (aoi>=7 & aoi <=9)


//Eliminamos de la muestra a los menores de 16 años.
drop if edad5<16

//Generar variables
	*Clasificación por "sexo"
gen total=(sexo1==1 | sexo==6)
gen hombres =(sexo1==1)
gen mujeres =(sexo1==6)
tab hombres
gen str genero="  "
replace genero = "Hombres" if hombres==1
replace genero = "Mujer" if mujeres==1 


	*Clasificación por "edad"
sum edad5
gen edad = 1 if (edad5>=16 & edad5<20) //para edad entre 16 y 29
replace edad = 2 if (edad5>=20 & edad5<30) //para edad entre 20 y 29
replace edad = 3 if (edad5>=30 & edad5<40) //para edad entre 30 y 39
replace edad = 4 if (edad5>=40 & edad5<50) //para edad entre 40 y 49
replace edad = 5 if (edad5>=50 & edad5<67) //para edad entre 50 y 67
tabstat edad5 , stats(p1 p5 mean med r p95 p99)
hist edad, percent

	*Clasificación por "estudios"
gen noEstudios = (nforma=="AN" | nforma=="P1")
gen educPrim=(nforma=="P2" | nforma=="S1")
gen educSec=(nforma=="SG" | nforma=="SP")
gen educTer=(nforma=="SU")
tab noEstudios

	*Clasificación por "sector laboral"
tab ocup1
gen cualificacionAlta = ( (ocup1>=0 & ocup1<=3) | ocupa>=0 & ocupa<=3)
gen cualificacionMedia = ( (ocup1>=4 & ocup1<=8) | ocupa>=4 & ocupa<=8)
gen cualificacionBaja = (ocup1==9 | ocupa==9) 

	
	*Clasificación por "tipo de contrato"
*ducon1
gen contratoIndefinido = (ducon1==1)
gen contratoTemporal = (ducon1==6)

	*Clasificación por "desempleo"
tab itbu 	//Tiempo que lleva buscando empleo
gen larga_duracion = (itbu==7 | itbu==8)
tab larga_duracion if parado==1
gen desempleado_3meses = (itbu== 1 | itbu ==2)
tab desempleado_3meses
gen desempleo_1año = (itbu==4 | itbu==5)
gen desempleoMenos1año = (itbu<5)

	*Clasificación por "sector productivo"
gen agricultura = ( act1==0 | acta==0)
gen industa = ( (act1>=0 & act1<=3) | (acta>=1)& (acta<=3))
gen construccion = (act1==4|acta==4)
gen servicios = (( act1>=5 & act1<=9) | (acta>=5 & acta<=9))

	*Clasificación por nacionalidad
gen inmigrante = (nac==3)
gen nativo = (nac==1)
gen doblenacionalidad = (nac==2)

	*Clasificacion inscritos
gen solo_inscrito=1 if (parado==1 & ofemp==2)

	*Factor de elevación
replace factorel= round(factorel/100)

*Comunidades autonomas
gen andal= ccaa==01			//Andalucia
gen ara= ccaa==02			//Aragon
gen astu= ccaa==03			//Principado de Asturias
gen isbal= ccaa==04			//Islas Baleares
gen canar= ccaa==05			//Islas Canarias
gen cant= ccaa==06			//Cantabria
gen castleon= ccaa==07		//Castilla-Leon
gen castman= ccaa==08		//Castilla-La Mancha
gen cata= ccaa==09			//Cataluña
gen valen= ccaa==10			//Comunidad Valenciana
gen extre= ccaa==11			//Extremadura
gen gal= ccaa==12			//Galicia
gen mad= ccaa==13			//Comunidad de Madrid
gen mur= ccaa==14			//Murcia
gen nav= ccaa==15			//Navarra
gen vasc= ccaa==16			//Pais Vasco
gen rio= ccaa==17			//La Rioja
gen ceumel= (ccaa==51 | ccaa==52)	//Ceuta y Melilla

*generar etiquetas para ccaa con label
label var andal "Andalucia"
label var ara "Aragon"
label var astu "Principado de Asturias"
label var isbal "Islas Baleares"
label var canar "Islas Canarias"
label var cant "Cantabria"
label var castleon "Castilla-Leon"
label var castman "Castilla-La Mancha"
label var cata "Cataluña"
label var valen "Valencia"
label var extre "Extremadura"
label var gal "Galicia"
label var mad "Madrid"
label var mur "Murcia"
label var nav "Navarra"
label var vasc "Pais Vasco"
label var rio "La Rioja"
label var ceumel "Ceuta y Melilla"

*use "EPA_muestraCompleta_VFstata_VarGen"
*save "EPA_muestraCompleta_VFstata_VarGen", replace
*export delimited "C:\Users\34654\Desktop\Big_Data\Master\TFM\microdatosEPA_md\EPA_muestraCompleta_VFstata.csv", replace

************/
