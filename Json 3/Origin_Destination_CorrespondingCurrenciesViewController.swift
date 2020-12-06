//
//  Origin_Destination_CorrespondingCurrenciesViewController.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/9/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import UIKit


//USD es a variable de referencia para convertir


//For the switcher

//button images

var image1 = UIImage()

var image2 = UIImage()

// currency description labels

var label1 = ""

var label2 = ""

// currency symbols

var symbol1 = ""

var symbol2 = ""

//timer

 var timer: Timer?

class Origin_Destination_CorrespondingCurrenciesViewController: UIViewController {
    
    
    
    @IBOutlet var toolbar2: UIToolbar!
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
         view.endEditing(true)
        
    }
    
    
    @IBAction func returnToMainMenu(_ sender: UIButton) {
        
        performSegue(withIdentifier: "converter->mainMenu", sender: self)
        
    }
    
    
    @IBOutlet var returnToMainMenu: UIButton!
    
//    @IBAction func calculateButton(_ sender: UIBarButtonItem) {
//        
//    
//            
//        let valueConverted = unisexMoneyconvertion(input: inputCountry1, xCountryOfOrigin: diccionarioDeXs[countriesPositionsVC1[removedOrigin]!]!, xCountryOfDestination: diccionarioDeXs[countriesPositionsVC2[removedDestination]!]!, tapCountIdentifier: tapCount.count)
//        
//        outputCountry2.text = (" \(convertDoubleToCurrency(input: valueConverted) ?? "0")")
//        
//        
//    }
    
    
    func automaticCalculation() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {
            (_) in
            
            if diccionarioDeXs[countriesPositionsVC1[removedOrigin] ?? "0"] != nil && diccionarioDeXs[countriesPositionsVC2[removedDestination] ?? "0"] != nil {
                
                
                let valueConverted = self.unisexMoneyconvertion(input: self.inputCountry1, xCountryOfOrigin: diccionarioDeXs[countriesPositionsVC1[removedOrigin]!]!, xCountryOfDestination: diccionarioDeXs[countriesPositionsVC2[removedDestination]!]!, tapCountIdentifier: self.tapCount.count)
                
                self.outputCountry2.text = (" \(self.convertDoubleToCurrency(input: valueConverted) ?? "0")")
                
            }
            
            
        }
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar
        //var navigationBarAppearace = UINavigationBar.appearance()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //----------------------------
        
        
        print(xChile!)
        
        print(xPeru!)
        
        
    
        
        
        //dsps puedes hacer un ciclo recursivo para dar update al diccionario de las Xs (cuando tengas todos los Json listos
        
        diccionarioDeXs.updateValue(1.0, forKey: "usa")
        
        //solo basta que actualices el diccionario de las Xs
        diccionarioDeXs.updateValue(xChile!, forKey: "chile")
        diccionarioDeXs.updateValue(xPeru!, forKey: "peru")
        diccionarioDeXs.updateValue(xArgentina!, forKey: "argentina")
        diccionarioDeXs.updateValue(xUK, forKey: "uk")
        diccionarioDeXs.updateValue(xItalia, forKey: "italia")
        diccionarioDeXs.updateValue(xJapan, forKey: "japon")
        
        
       setter(positionRemovedOrigin: removedOrigin, positionRemovedDestination: removedDestination)
        
        
        //UIProperties
        //Buttons
        
        //1
        
        buttonCountry1.layer.borderWidth = 1.0
        //Recuerda el +1 en el diseño del boton
        buttonCountry1.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        buttonCountry1.layer.cornerRadius = 2.0
        
        buttonCountry1.setTitle("               ▼", for: .normal)
        
      
        
        //2
        
        buttonCountry2.layer.borderWidth = 1.0
        //Recuerda el +1 en el diseño del boton
        buttonCountry2.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        buttonCountry2.layer.cornerRadius = 2.0
        
        buttonCountry2.setTitle("               ▼", for: .normal)
        
        
        //Text Inputs
        
        inputCountry1.layer.borderWidth = 1.0
        inputCountry1.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        inputCountry1.layer.cornerRadius = 5.0
        inputCountry1.frame.size.height = 36
        
        
        
        //--------------
        
        outputCountry2.layer.borderWidth = 1.0
        
        /*
        outputCountry2.layer.borderColor = UIColor(hue: 0.4417, saturation: 1, brightness: 0.43, alpha: 1.0).cgColor    //Starbucks color   */
        outputCountry2.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        outputCountry2.layer.cornerRadius = 5.0
        outputCountry2.frame.size.height = 36
        
        //UILabels:
        
        if Locale.current.identifier == "en_CL" {
            
            //the default when coding because of the project language
            //change it to the spanish speaking countries identifiers
            
            self.title = ""
            
            let backButton = UIBarButtonItem(title: español["vcDestinationTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            
            
        }
        
        
        
       /*Use the RgB from the code of color from nice brands en el UIPicker*/
        
        //Para que funcione el toolbar
        
        inputCountry1.inputAccessoryView = toolbar2
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("removedOrigin = \(removedOrigin)", "removedDestination = \(removedDestination)" )
        
        print(countriesPositionsVC1, "Origin")
        print(countriesPositionsVC2, "Destination")
        
        print(diccionarioDeXs)
        
        
        automaticCalculation() //if you dont get the data, it fails
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?){
        inputCountry1.resignFirstResponder()
       
        
        /*para que al apretar la pantalla dsps de poner el input se vaya el teclado de numeros */
        
    }
    
   
    
    func setter (positionRemovedOrigin: Int, positionRemovedDestination: Int){
        
        //el setter tmbn es unisex
        
        if positionRemovedOrigin == removedOrigin && positionRemovedDestination == removedDestination{
            
            //diccionarioDeAcronimos[countriesPositionsVC1[removedOrigin]!]
            //un diccionario que busca la palabra sacada de otro diccionario
            
            //es a la inversa por la logica de conversion (yo quiero saber cuanto me cuesta al EN OTRO PAIS)
            
            //Country1 = Destination
            //Country2 = Origin
            
            buttonCountry2.setImage(diccionarioDeImagenesPequeñas[countriesPositionsVC1[removedOrigin]!], for: .normal)
            buttonCountry1.setImage(diccionarioDeImagenesPequeñas[countriesPositionsVC2[removedDestination]!], for: .normal)
            
            
            
            labelCountry2.text = diccionarioDeAcronimos[countriesPositionsVC1[removedOrigin]!]
            labelCountry1.text = diccionarioDeAcronimos[countriesPositionsVC2[removedDestination]!]
           
            
            moneySymbolCountry2.text = diccionarioDeSimbolos[countriesPositionsVC1[removedOrigin]!]
            moneySymbolCountry1.text = diccionarioDeSimbolos[countriesPositionsVC2[removedDestination]!]
            
            
            
            //Setters for Switcher
            
            image2 = diccionarioDeImagenesPequeñas[countriesPositionsVC2[removedDestination]!]!
            image1 = diccionarioDeImagenesPequeñas[countriesPositionsVC1[removedOrigin]!]!
            
            label2 = diccionarioDeAcronimos[countriesPositionsVC2[removedDestination]!]!
            label1 = diccionarioDeAcronimos[countriesPositionsVC1[removedOrigin]!]!
            
            symbol2 = diccionarioDeSimbolos[countriesPositionsVC2[removedDestination]!]!
            symbol1 = diccionarioDeSimbolos[countriesPositionsVC1[removedOrigin]!]!
            
           
        }
        
       
        
        
    }
    
    //Money Convertions
    
    
    //el output
    func convertDoubleToCurrency(input: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: diccionarioDeIds[countriesPositionsVC1[removedDestination]!]!)
        
        return numberFormatter.string(from: NSNumber(value: input))!
    }
    
    /*Cambias el identifier con la lista de cada pais, pones .currency para paises extranjeros (aparece el simbolo Yen por ejemplo) */
    
    
    //el input
    func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: diccionarioDeIds[countriesPositionsVC1[removedOrigin]!]!)
        
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    
    /*every calculation is based on the value of 1 USD. e.g: 3.85 PEN = 1 USD
     678.9 CLP = 1 USD -->  678.9 CLP = 3.85 PEN*/
    
    
    
    func convertMoney(input:UITextField, xCountryOfOrigin:Double, xCountryOfDestination:Double)-> Double {
        let x = input.text
        
        //let xDouble = Double(x!)
        
        let xModified = x!.replacingOccurrences(of: ",", with: ".")
         
        let xDouble = Double (xModified)
        
        //only if you need to modify a currency
        
        //esto es solo valido para los paises con SI, en caso contrario va a colapsar (se debe reemplazar la coma por el punto o bien detectar el pais (posble bug)
        
        
        //Array count es el Array correspondiente a la divisa (e.g. infodolararrayperu (el destination)) y el .count
        
        if xDouble != nil{
            let amount = xDouble!*(xCountryOfOrigin/xCountryOfDestination)
            let amountRounded = round(amount*1000)/1000
            return amountRounded
            
        }else{
            let amount = 0.0
            return amount
            
        }
        
    }
 
 
    
    func convertMoneyInverse(input:UITextField, xCountryOfOrigin:Double, xCountryOfDestination:Double)-> Double{
        
        let x = input.text
        
        let xModified = x!.replacingOccurrences(of: ",", with: ".")
        
        let xDouble = Double (xModified)
        
        
        
        if  xDouble != nil {
            let amount = xDouble!*(xCountryOfDestination/xCountryOfOrigin)
            let amountRounded = round(amount*1000)/1000
            return amountRounded
            
            
        }else{
            let amount = 0.0
            return amount
            
        }
        
    }
    /* Se usa usd, pero corresponde al identificador Foreign Money */
    
    func unisexMoneyconvertion(input: UITextField, xCountryOfOrigin:Double, xCountryOfDestination:Double,  tapCountIdentifier: Int) -> Double{
        
        if (tapCountIdentifier) % 2 == 0 { //el numero es par
            
            return convertMoney(input: input, xCountryOfOrigin: xCountryOfOrigin, xCountryOfDestination: xCountryOfDestination)
            
        }else if (tapCountIdentifier) % 2 != 0 { //el numero es impar
            return convertMoneyInverse(input: input, xCountryOfOrigin: xCountryOfOrigin, xCountryOfDestination: xCountryOfDestination)
            
            
        }
        return unisexMoneyconvertion(input: input,xCountryOfOrigin: xCountryOfOrigin, xCountryOfDestination: xCountryOfDestination, tapCountIdentifier: tapCountIdentifier)
        
    }
 
 
    //------------------------------------------
    //Text Fields
    
    
    @IBOutlet var inputCountry1: UITextField!
    
    
    
    
    //------------------------------------------
    //Labels
    
    //1
    
    @IBOutlet var labelCountry1: UILabel!
    
    @IBOutlet var labelMoneySymbolCountry1: UILabel!
    
    
    @IBOutlet var moneySymbolCountry1: UILabel!
    
    //2
    
    @IBOutlet var labelCountry2: UILabel!
    
    
    @IBOutlet var outputCountry2: UILabel!
    
    
    @IBOutlet var moneySymbolCountry2: UILabel!
    
    //------------------------------------------
    //Buttons
    
    //buttonCountry1
    
    @IBAction func buttonCountry1(_ sender: UIButton) {
    }
    
    @IBOutlet var buttonCountry1: UIButton!
    //---------------------
    //buttonCountry2
    
    @IBAction func buttonCountry2(_ sender: UIButton) {
    }
    
    @IBOutlet var buttonCountry2: UIButton!
    
    
    //---------------------
    //switcher
    //a generic switcher valid for EVERY Situation
    
    var tapCount = [Int]()
    var x = 0
    
    func buttonTapped(x:Int) {
        let x = x+1
        tapCount.append(x)
    }
    
    @IBAction func switcher(_ sender: UIButton) {
        
        buttonTapped(x: x)
        
        
        inputCountry1.text = ""
        outputCountry2.text = ""
        moneySymbolCountry1.text = "\(String(describing: moneySymbolCountry2))"
        moneySymbolCountry2.text = "\(String(describing: moneySymbolCountry1))"
        
        //el describing es para que no se pierda el valor
        
        if (tapCount.count) % 2 == 0 { //el numero es par
            
            //DOLAR
            
            buttonCountry1.setImage(image2, for: .normal)
            buttonCountry2.setImage(image1, for: .normal)
             
            //set the image without losing the value
            
            labelCountry1.text = label2
            labelCountry2.text = label1
            
            moneySymbolCountry1.text = symbol2
            
            moneySymbolCountry2.text = symbol1
 
 
            
        }
        
        if (tapCount.count) % 2 != 0 { //el numero es impar
            
            //DOLAR
            buttonCountry1.setImage(image1, for: .normal)
            buttonCountry2.setImage(image2, for: .normal)
            
            labelCountry1.text = label1
            labelCountry2.text = label2
            
            moneySymbolCountry1.text = symbol1
            moneySymbolCountry2.text = symbol2
            
        }
        
        
    }
    
    //---------------------
    //Return
    
    @IBAction func returnButtonOriginDestinationCurrencies(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueReturnButtonCurrenciesDestination", sender: self)
        

        
        //para reiniciar la variable cada vez que se regresa cuando se equivoca en la eleccion
        //recuerda que lastPositionSet3 es la del origion y 4 es del Destination
        
    }
    
    @IBOutlet var returnButtonOriginDestinationCurrencies: UIButton!
    
    //------------------------------------------

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
