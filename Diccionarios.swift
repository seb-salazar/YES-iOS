//
//  Diccionarios.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 2/9/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import Foundation
import UIKit

let diccionarioDeAcronimos = ["argentina":"ARS", "chile":"CLP", "peru":"PEN", "uk":"GBP", "italia":"EUR", "japon":"JPY", "usa":"USD"]

let diccionarioDeImagenesPequeñas = ["argentina":#imageLiteral(resourceName: "smallArgentina"), "chile":#imageLiteral(resourceName: "smallChile"), "peru":#imageLiteral(resourceName: "smallPeru"), "uk":#imageLiteral(resourceName: "smallUk"), "italia":#imageLiteral(resourceName: "smallItalia"), "japon":#imageLiteral(resourceName: "smallJapon"), "usa": #imageLiteral(resourceName: "smallUsa")]

let diccionarioDeSimbolos = ["argentina":"$", "chile":"$", "peru":"$", "uk":"£", "italia":"€", "japon":"¥", "usa":"$"]

let diccionarioDeIds = ["argentina":"es_AR", "chile":"es_CL", "peru":"es_PE", "uk":"en_GB", "italia":"it_IT", "japon":"ja_JP", "usa":"en_US"]

var diccionarioDeXs = [String:Double]()

//todos los diccinoarios estasn en español, sin tildes


//solo debes:
/*
 
 1) modificar estos diccionarios y los array (los 5 del Origin y 1 del Destination) del VC1 (Origin)
 2) cambiar los intervalos a medida que agregas banderas en los dos VCs
 3) inicializar las variables del diccionarioDeXs (hasta que tengas todos los Json listos)
 4) crear los Json de acuerdo al patron ya establecido e inicializarlos en el mainMenu
 
 y listo!, todo lo demas ya es unisex
 
 
 
 
 
 */

//EUROPA

//https://exchangeratesapi.io

//https://api.exchangeratesapi.io/latest
//Euros to Anything

//https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml
//XML from the EUROPEAN CENTRAL BANK





//ARGENTINA

//http://ws.geeklab.com.ar/dolar/get-dolar-json.php
//Dolar a peso argentino, libre: la oficial, blue: la paralela

//http://estadisticasbcra.com/api/documentacion
//Del BCRA(banco central republica argentina), el token expira cada un año






//BRASIL

//https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)?@moeda=%27EUR%27&@dataCotacao=%2703-06-2019%27&$top=100&$format=json&$select=cotacaoVenda
//Euro a Real Brasileño
//puedes cambiar EUR por USD por ejemplo (en este link salen los posibles cambios de divisas https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/Moedas?$top=100&$format=json)
//tambien debes hacer que el sistema baje y ponga la fecha en el link, en el main menu, puedes poner un timer para obtener la fecha
//se usa el valor de venta mas alto (puedes meterlos todos en un array y sacar el maximo)



//COLOMBIA
//TRM : http://app.docm.co/prod/Dmservices/Utilities.svc/GetTRM



//usualmente tienen un maximo de 100 request al dia, podrias crear un servidor que descargara el valor una vez y luego lo copiara y lo distribuyera a traves de un link a los demas dispositivos

//se utiliza el valor de VENTA porque representa lo que tendria que pagar yo si quisiera cambiar mis monedas por las del pais local, por lo tanto, es como lo que me costaria comprar esas cosas (ya que tendria que cambiar mis monedas para poder comprar en dicho pais)

//Recuerda poner que los valores son APROXIMADOS, y depende de las CASAS DE CAMBIO
//solo ser usados como referencia al comprar
