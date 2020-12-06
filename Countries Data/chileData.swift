//
//  chileData.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/15/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import Foundation
import UIKit


//DATA DOWNLOAD--------------------------------

var infoDolarArrayChile = [Double]()


let xChile = UserDefaults.standard.object(forKey: "valorDelDolarChile") as? Double



func downloadDataChileUsingURL() {
    
    let calendar = Calendar.current
    let today = Date()
    
    var urlStringChile = ""

    if calendar.isDateInWeekend(today) {
        //infoDolarArray[0] te dara el Double del dolar, que luego se transforma en String con coma
        
        let date = Date().previous(.friday)

        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        
        urlStringChile = "https://api.sbif.cl/api-sbifv3/recursos_api/dolar/\(year)/\(month)/dias/\(day)?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"
    }
    else {
        
        urlStringChile = "https://api.sbif.cl/api-sbifv3/recursos_api/dolar?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"
    }
    
    
    let url = NSURL(string: urlStringChile)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //print(jsonObj!.value(forKey: "Dolares"))
            
            if let dolarArray = jsonObj!.value(forKey: "Dolares") as? NSArray {
                for dolar in dolarArray{
                    if let valoresDict = dolar as? NSDictionary {
                        if let precioDelDolar = valoresDict.value(forKey: "Valor") {
                            //print (precioDelDolar)
                            
                            
                            let x = precioDelDolar as! String
                            let modifiedx = x.replacingOccurrences(of: ",", with: ".")
                            let xDouble = Double(modifiedx)
                            
                            infoDolarArrayChile.append(xDouble as! Double)
                            
                            
                            
                            if x != "" {
                                UserDefaults.standard.set(infoDolarArrayChile[0], forKey: "valorDelDolarChile")
                                
                                
                            }
                            

                            
                            
                            
                            print (infoDolarArrayChile)
                            print(infoDolarArrayChile.count)
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            OperationQueue.main.addOperation({
                //   self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}





//-------------------------------------------------------


let x1 = UserDefaults.standard.object(forKey: "valorDelDolar") as? Double   //DOLAR
let x2 = UserDefaults.standard.object(forKey: "valorUF") as? Double        //UF
let x3 = UserDefaults.standard.object(forKey: "valorDelEuro") as? Double    //EURO


var infoDolarArray = [Double]()

//infoDolarArray[0] te dara el Double del dolar, que luego se transforma en String con coma

let urlString = "https://api.sbif.cl/api-sbifv3/recursos_api/dolar?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"


func downloadJsonUsingURL() {
    let url = NSURL(string: urlString)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //print(jsonObj!.value(forKey: "Dolares"))
            
            if let dolarArray = jsonObj!.value(forKey: "Dolares") as? NSArray {
                for dolar in dolarArray{
                    if let valoresDict = dolar as? NSDictionary {
                        if let precioDelDolar = valoresDict.value(forKey: "Valor") {
                            //print (precioDelDolar)
                            
                            
                            let x = precioDelDolar as! String
                            let modifiedx = x.replacingOccurrences(of: ",", with: ".")
                            let xDouble = Double(modifiedx)
                            
                            infoDolarArray.append(xDouble as! Double)
                            
                            if x != "" {
                                UserDefaults.standard.set(infoDolarArray[0], forKey: "valorDelDolar")
                            }
                            
                            print (infoDolarArray)
                            print(infoDolarArray.count)
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            OperationQueue.main.addOperation({
                //   self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}





var infoEuroArray = [Double]()

let urlStringEuro = "https://api.sbif.cl/api-sbifv3/recursos_api/euro?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"


func downloadEuroJsonUsingURL() {
    let url = NSURL(string: urlStringEuro)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            
            if let euroArray = jsonObj!.value(forKey: "Euros") as? NSArray {
                for euro in euroArray{
                    if let valoresDict = euro as? NSDictionary {
                        if let precioDelEuro = valoresDict.value(forKey: "Valor") {
                            //print (precioDelDolar)
                            
                            
                            let x = precioDelEuro as! String
                            let modifiedx = x.replacingOccurrences(of: ",", with: ".")
                            let xDouble = Double(modifiedx)
                            
                            infoEuroArray.append(xDouble as! Double)
                            
                            if x != "" {
                                UserDefaults.standard.set(infoEuroArray[0], forKey: "valorDelEuro")
                            }
                            
                            print (infoEuroArray)
                            print(infoEuroArray.count)
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            OperationQueue.main.addOperation({
                // self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}






var infoUFArray = [Double]()

//infoDolarArray[0] te dara el Double del dolar, que luego se transforma en String con coma

let urlStringUF = "https://api.sbif.cl/api-sbifv3/recursos_api/uf?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"

func downloadUFJsonUsingURL() {
    let url = NSURL(string: urlStringUF)
    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
        
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            
            //print(jsonObj!.value(forKey: "Dolares"))
            
            if let UFArray = jsonObj!.value(forKey: "UFs") as? NSArray {
                for uf in UFArray{
                    if let valoresDict = uf as? NSDictionary {
                        if let precioUF = valoresDict.value(forKey: "Valor") {
                            print (precioUF)
                            
                            //Para que el label tenga puntos y comas
                            
                            let x = precioUF as! String
                            let modifiedx = x.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                            let xDouble = Double(modifiedx)
                            
                            infoUFArray.append(xDouble as! Double)
                            
                            if x != "" {
                                UserDefaults.standard.set(infoUFArray[0], forKey: "valorUF")
                            }
                            
                            // print (self.infoUFArray)
                            // print(self.infoUFArray.count)
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            OperationQueue.main.addOperation({
                //  self.moneyTableView.reloadData()
            })
        }
    }).resume()
    
    
}


extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
