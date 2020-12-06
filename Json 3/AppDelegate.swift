//
//  AppDelegate.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 12/27/18.
//  Copyright © 2018 Sebastian Salazar. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        
        //for downloading the data when app is closed
        //careful with the dolar value, because of banco central de Chile restrictions (10 000)
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        //we use swiftyJSON to perform the parsing easily
        
        
        if let vc = window?.rootViewController as? ViewController {
            
           
            
            let urlString = "https://api.sbif.cl/api-sbifv3/recursos_api/dolar?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"


    
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error)  in
                print("done")
                
                guard let data = data, error == nil else {
                    completionHandler(.failed)
                    return
                }
                
                do {
                    let json = try JSON(data:data)
                    
                    let dolar = json["Dolares"][0]["Valor"].string!
//                    let euro = json["Euros"][0]["Valor"].string!
//                    let uf = json["UFs"][0]["Valor"].string!
                    
                    DispatchQueue.main.async {
                        vc.updateLabelsLocalValues(dolar: dolar)
                    }
                    
                    completionHandler(.newData)
                    
                } catch {
                    completionHandler(.failed)
                    print("failed to parse")
                }
                
            }).resume()
        }
                
            
    }
    

//        downloadJsonUsingURL()
//        downloadEuroJsonUsingURL()
//        downloadUFJsonUsingURL()
//
//
//
//        completionHandler(.newData)
//
//        print("data received")
    
       // usa el codigo de la foto
    
        
        //habria problema si descargan la app un finde
        
    

       
                        
                        

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

