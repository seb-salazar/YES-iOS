//
//  euroZoneData.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 3/7/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//


import Foundation
import UIKit


import CheatyXML

//the pod file makes it easy, but you MUST KNOW how to PARSE XML only using code, in case the pod fails


//Valor de 1 Euro en Dolares --> por eso se usa 1/infoDolarArrayEuro[0]


var infoEuroCentralBank = [String:String]()




let xEuro = UserDefaults.standard.object(forKey: "valorDelEuro") as? Double

let xmlString = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
let xmlUrl = URL(string: xmlString)


func parseEuroDataXML () {
    
    
    let parser: CXMLParser! = CXMLParser(contentsOfURL: xmlUrl!)
    
    let numberOfElements : Int = parser["Cube"]["Cube"]["Cube"].count
    
    for i in 0..<numberOfElements {
        
        let currencyString = parser["Cube"]["Cube"]["Cube", i].attribute("currency").stringValue  // "USD"
        let rateString = parser["Cube"]["Cube"]["Cube", i].attribute("rate").stringValue  // "1.12.."
        
        
        
        infoEuroCentralBank[currencyString] = rateString
        
        
        print(infoEuroCentralBank)
        print("nº of elements: \(numberOfElements)")
        
    }
    
}



//remember that you relay in the ECB xml availability, try to use User Defaults in the future

//Get a TEAM (computer sciences)

//it is not actually an xCountry
let xJapan = Double(infoEuroCentralBank["JPY"]!)!*(1/Double(infoEuroCentralBank["USD"]!)!)
//te va a dar el valor en ¥ por cada 1 dolar

let xUK = Double(infoEuroCentralBank["GBP"]!)!*(1/Double(infoEuroCentralBank["USD"]!)!)

let xItalia = (1/Double(infoEuroCentralBank["USD"]!)!)
//xItalia = xEuro




//---------------------

let xUS = 1.0 //ya que se usa, para todas las currencies, 1 USD COMO REFERENCIA

//--------------------




//
//
//
//
//
//
//class Currency: CustomStringConvertible {
//
//    var currency  = ""
//    var rate = ""
//
//    var description: String {
//
//        return "currency:\(currency), rate:\(rate)"
//    }
//
//}
//
//
//class currencyParsingXml : NSObject {
//
//    var xmlParser: XMLParser?
//    var currency: [Currency] = []
//    var xmlText = ""
//    var currentCurrency: Currency?
//
//    init(withXML xml: String) {
//
//        if let data = xml.data(using: String.Encoding.utf8){
//
//            xmlParser = XMLParser(data: data)
//
//        }
//    }
//
//}
//
//
//
////XML Parser Delegates
//
//extension currencyParsingXml : XMLParserDelegate {
//
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
//
//        xmlText = ""
//
//        if elementName == "currency" {
//
//            currentCurrency = Currency()
//
//        }
//    }
//

    
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        <#code#>
//    }
//}




