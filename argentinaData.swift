//
//  argentinaData.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 3/6/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import Foundation
import UIKit


//DATA DOWNLOAD--------------------------------

/*La data corresponde al precio de Compra del dia anterior, proporcionada por el Banco Central de Reserva Del Peru*/

//Saved Data Values

let xArgentina = UserDefaults.standard.object(forKey: "valorDelDolarArgentina") as? Double   //Valor de 1 DOLAR en soles peruanos

var infoDolarArrayArgentina = [Double]()

//infoDolarArray...[0] te dara el Double del dolar, que luego se transforma en String con coma

let urlStringArgentina = "http://ws.geeklab.com.ar/dolar/get-dolar-json.php"



func downloadDataArgentinaUsingURL() {
    let url = NSURL(string: urlStringArgentina)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //print(jsonObj!.value(forKey: "Dolares"))
            
            if let precioFinal = jsonObj!.value(forKey: "blue"){
                
                
                // print (precioFinal[0])
                
                
                let x = precioFinal as! String
                
                infoDolarArrayArgentina.append(Double(x)!)
                
                if x != "" {
                    UserDefaults.standard.set(infoDolarArrayArgentina[0], forKey: "valorDelDolarArgentina")
                }
                
                
                
                print (infoDolarArrayArgentina)
                print(infoDolarArrayArgentina.count)
                
                
                
                
                
            }
            
            
            
            OperationQueue.main.addOperation({
                //   self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}


