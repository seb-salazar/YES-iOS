//
//  peruData.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/15/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import Foundation
import UIKit


//DATA DOWNLOAD--------------------------------

/*La data corresponde al precio de Compra del dia anterior, proporcionada por el Banco Central de Reserva Del Peru*/

//Saved Data Values

let xPeru = UserDefaults.standard.object(forKey: "valorDelDolarPeru") as? Double   //Valor de 1 DOLAR en soles peruanos

var infoDolarArrayPeru = [Double]()

//infoDolarArray...[0] te dara el Double del dolar, que luego se transforma en String con coma

let urlStringPeru = "https://estadisticas.bcrp.gob.pe/estadisticas/series/api/PD04638PD/json"



func downloadDataPeruUsingURL() {
    let url = NSURL(string: urlStringPeru)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //print(jsonObj!.value(forKey: "Dolares"))
            
            if let dolarDict = jsonObj!.value(forKey: "periods") as? NSArray{
                
                if let precioDelDolar = dolarDict.lastObject as? NSDictionary {
                    
                    if let precioFinal = precioDelDolar.value(forKey: "values") as? NSArray {
                        
                        
                       // print (precioFinal[0])
                        
                        
                        let x = precioFinal[0] as! String
                        
                        infoDolarArrayPeru.append(Double(x)!)
                        
                        if x != "" {
                            UserDefaults.standard.set(infoDolarArrayPeru[0], forKey: "valorDelDolarPeru")
                        }
                        
                        
                        
                        print (infoDolarArrayPeru)
                        print(infoDolarArrayPeru.count)
 
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            OperationQueue.main.addOperation({
                //   self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}

