//
//  MainMenuViewController.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/8/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import UIKit

//Sacale el CocoaPods al Proyecto

let button1Name = "Local Values"
let button2Name = "Travel Mode"

class MainMenuViewController: UIViewController {
    
    
    
   

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationController = segue.destination as! OriginCountryViewController
        
      
    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadDataPeruUsingURL()
        downloadDataChileUsingURL()
        downloadDataArgentinaUsingURL()
        
        
        parseEuroDataXML()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
      
        //UIProperties
        
    
        button1.layer.borderWidth = 1.0
        button1.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        button1.layer.cornerRadius = 10.0
        
        
        
    
        button2.layer.borderWidth = 1.0
        button2.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        button2.layer.cornerRadius = 10.0
        
        //navigation bar
        //var navigationBarAppearace = UINavigationBar.appearance()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //
        
        print(Locale.current.identifier)
        print(Locale.isoCurrencyCodes)
       
        
        
        //UILabels:
        
        if Locale.current.identifier == "en_CL" {
            
            //the default when coding because of the project language
            //change it to the spanish speaking countries identifiers
            
            self.title = español["vcMainMenuTitle"]
            
            button1.setTitle(español["button1"], for: .normal)
            button2.setTitle(español["button2"], for: .normal)
            
            
            
        }
        
    }
    
    
    
    
    
 
    
    
    
    
    //
    @IBAction func button1(_ sender: UIButton) {
        
        performSegue(withIdentifier: "main->local", sender: self)
        
    }
    
    @IBOutlet var button1: UIButton!
    //To change the Properties of your button
    //
    
    
    @IBAction func button2(_ sender: UIButton) {
        
        performSegue(withIdentifier: "menu->origin", sender: self)
    }
    
    @IBOutlet var button2: UIButton!
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    

}
