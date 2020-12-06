//
//  ViewController.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 12/27/18.
//  Copyright © 2018 Sebastian Salazar. All rights reserved.
//

//Remember the allow arbitrary loads in App T ransport
import UIKit

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)   //int
let month = calendar.component(.month, from: date)  //int
let year = calendar.component(.year, from: date)    //int


let meses = [1:"Enero", 2:"Febrero", 3:"Marzo", 4:"Abril", 5:"Mayo", 6:"Junio", 7:"Julio", 8:"Agosto", 9:"Septiembre", 10:"Octubre",11:"Noviembre", 12:"Diciembre" ]

let months = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August", 9:"September", 10:"October",11:"November", 12:"December" ]



/*Las variables aqui son variables globales, que se pueden acceder por TODOS los View Controllers */



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    
    //date
    
    @IBOutlet var date: UILabel!
    
    
    //Toolbar
    
    @IBOutlet var toolbar: UIToolbar!
    
    
    
    
    
    //Toolbar Items "without" code
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        view.endEditing(true)
        
    }
    
    
    /*Arregla para que el x sea el valor fijo del viernes, recuerda que sacaste el parametro Array: Double (infoDolarArray[0] de todas las funciones*/
    
    
    @IBAction func calculateButton(_ sender: UIBarButtonItem) {
        
        //DOLAR
        let modifiedOutputLabelDolarValue = unisexMoneyconvertion(input: moneyInput, X: x1!,  ArrayCount: infoDolarArrayChile.count, tapCountIdentifier: tapCountUSD.count)
        
        moneyOutputLabel.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelDolarValue) ?? "0")")
        moneySymbolDolar.text = ""
        
        //EURO
        let modifiedOutputLabelEuroValue = unisexMoneyconvertion(input: moneyInputEuro, X: x3!,  ArrayCount: infoEuroArray.count, tapCountIdentifier: tapCountEUR.count)
        
        moneyOutputLabelEuro.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelEuroValue) ?? "0")")
        moneySymbolEuro.text = ""
        
        //UF
        let modifiedOutputLabelUFValue = ufPriceConvertion(input: UFInput)
        
        UFOutputLabel.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelUFValue) ?? "0")")
        moneySymbolUF.text = ""
    }
    
    
    
    //Para que se calcule usando el boton return
    @IBAction func moneyInputReturnButton(_ sender: UITextField) {
        
        //DOLAR
        let modifiedOutputLabelDolarValue = unisexMoneyconvertion(input: moneyInput, X: x1!,  ArrayCount: infoDolarArrayChile.count, tapCountIdentifier: tapCountUSD.count)
        
        /*El x (userDefaukts, crea un problema solo la primera vez que se usa la app,ya que como el valor nunca ha sido descargado antes aparece un nil, basta con volver a abrir la app y esperar que cargue el valor para que todo funcione a la perfeccion*/
        
        moneyOutputLabel.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelDolarValue) ?? "0")")
        moneySymbolDolar.text = ""
        
        
        //EURO
        let modifiedOutputLabelEuroValue = unisexMoneyconvertion(input: moneyInputEuro, X: x3!,  ArrayCount: infoEuroArray.count, tapCountIdentifier: tapCountEUR.count)
        
        moneyOutputLabelEuro.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelEuroValue) ?? "0")")
        moneySymbolEuro.text = ""
        
        
        //UF
        let modifiedOutputLabelUFValue = ufPriceConvertion(input: UFInput)
        
        UFOutputLabel.text = ("$ \(convertDoubleToCurrency(input: modifiedOutputLabelUFValue) ?? "0")")
        moneySymbolUF.text = ""
        
    }
    
    
//  // Return Button
//
//    @IBAction func returnButtonLocalValues(_ sender: UIButton) {
//
//        performSegue(withIdentifier: "segueReturnButtonLocalValues", sender: self)
//
//    }
//
//    @IBOutlet var returnButtonLocalValues: UIButton!
//
//
    

  //--------------------------------------------------------
    
    // OVERRIDES
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /*Para darle luz al status Bar, recuerda que (Recuerda que el view controller que se cambio a YES, eso genera un .lightContent != .default para este ViewcController en especifico, ademas no pusiste NADA en el APP delegate*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigation bar
        //var navigationBarAppearace = UINavigationBar.appearance()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        //--------------------------
        
        //DOLAR
        moneyInput.layer.borderWidth = 1.0
        moneyInput.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        moneyInput.layer.cornerRadius = 10.0
        
        //EURO
        moneyInputEuro.layer.borderWidth = 1.0
        moneyInputEuro.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        moneyInputEuro.layer.cornerRadius = 10.0
        
        //UF
        UFInput.layer.borderWidth = 1.0
        UFInput.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        UFInput.layer.cornerRadius = 10.0
       
        self.downloadJsonUsingURL()   //DOLAR
        self.downloadEuroJsonUsingURL() //EURO
        self.downloadUFJsonUsingURL()  //UF
        
        //DOLAR
        USDLabel.text = "USD"
        CLPLabel.text = "CLP"
        
        //EURO
        EURLabel.text = "EUR"
        CLP_EuroLabel.text = "CLP"
        
        //UF
        UFInputAmountLabel.text = "UF"
        UFLabel.text = "Price"
        
        
        
        
        
        //Para que funcione el toolbar
        moneyInput.inputAccessoryView = toolbar     //DOLAR
        moneyInputEuro.inputAccessoryView = toolbar   //EURO
        
        UFInput.inputAccessoryView = toolbar        //UF
        
        
        //
        
        
        //IMAGENES
        self.imagenLetrasDolar.image = UIImage(named: "dolarWhite")        //DOLAR
        self.imagenLetrasEuro.image = UIImage(named: "euroWhite")            //EURO
        self.imagenLetrasUF.image = UIImage(named: "ufWhite")                //UF
        
        
        
        
        
        
        if Locale.current.identifier == "en_CL" {
            
            //the default when coding because of the project language
            //change it to the spanish speaking countries identifiers
            
            self.title = ""
            
            
            //Para que el back button no tenga titulo o tenga otro
            let backButton = UIBarButtonItem(title: español["vcMainMenuTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            
            
            
            for i in meses.keys {
                
                if i == month {
                    
                    date.text = "\(day) de \(meses[month] ?? "x") del \(year)"
                    
                }
                
            }
            
        }
        
        else //Locale.current.identifier == "en_US" {
        {
            
            //the default when coding because of the project language
            //change it to the spanish speaking countries identifiers
            
            self.title = english["vcLocalValuesTitle"]
         
            for i in months.keys {
                
                if i == month {
                    
                    if day%10 == 1 {
                        
                        date.text = "\(months[month] ?? "x") \(day)st \(year)"
                        
                    } else if day%10  == 2 {
                        
                        //% 10 to get last digit, % 100 to get last 2 digits
                        
                        date.text = "\(months[month] ?? "x") \(day)nd \(year)"
                        
                    } else if day%10  == 3 {
                        
                        date.text = "\(months[month] ?? "x") \(day)rd \(year)"
                        
                    } else {
                        
                        date.text = "\(months[month] ?? "x") \(day)th \(year)"
                        
                    }
                    
                    // areglalo para dias como el 22 por ejemplo
                    
                }
                
                
            }
            
            
            
            
        }
        
       
        
        //Buttons
        
        /*
        returnButtonLocalValues.layer.borderWidth = 1.0
        returnButtonLocalValues.layer.borderColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.96, alpha: 1.0).cgColor
        returnButtonLocalValues.layer.cornerRadius = 10.0  */
        
        
        //Para que haya un done button en el keyboard, usando codigo
        /*
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([doneButton], animated: false)
        
        moneyInput.inputAccessoryView = toolBar
        */
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    /*
    @objc func doneClicked() {
        view.endEditing(true)
    }
    */
    
    //Saved Data Values
    
    let x1 = UserDefaults.standard.object(forKey: "valorDelDolarChile") as? Double   //DOLAR
    
    //let x1 = xChile   //DOLAR
    let x2 = UserDefaults.standard.object(forKey: "valorUF") as? Double        //UF
    let x3 = UserDefaults.standard.object(forKey: "valorDelEuro") as? Double    //EURO
    
    //
    
    override func viewDidAppear(_ animated: Bool) {
    
        //DOLAR
        if let x1 = UserDefaults.standard.object(forKey: "valorDelDolarChile") as? Double
        {
            labelPriceDisplay.text = ("$ \(convertDoubleToCurrency(input: x1) ?? "0")")
            moneyOutputLabel.text = ("$ \(convertDoubleToCurrency(input: x1) ?? "0")")
        }
        
        //UF
        if let x2 = UserDefaults.standard.object(forKey: "valorUF") as? Double
        {
           // let modifiedxToSI2 = String(x2)
            /*let modifiedxToSIComa2 = modifiedxToSI2.replacingOccurrences(of: ".", with: ",")
            
            labelPriceDisplayUF.text = ("$ \(modifiedxToSIComa2)")
            UFOutputLabel.text = ("$ \(modifiedxToSIComa2)") */
            
            labelPriceDisplayUF.text = ("$ \(convertDoubleToCurrency(input: x2) ?? "0")")
            UFOutputLabel.text = ("$ \(convertDoubleToCurrency(input: x2) ?? "0")")
            
        }
        
        if let x3 = UserDefaults.standard.object(forKey: "valorDelEuro") as? Double
        {
            labelPriceDisplayEuro.text = ("$ \(convertDoubleToCurrency(input: x3) ?? "0")")
            moneyOutputLabelEuro.text = ("$ \(convertDoubleToCurrency(input: x3) ?? "0")")
        }
        
        
        
    }
    
    //for performing the UIBAckgroundFetch
    
    func updateLabelsLocalValues(dolar: String){
        
        print("updating Labels")
        
        
        labelPriceDisplay.text = dolar
//        labelPriceDisplayEuro.text = euro
//        labelPriceDisplayUF.text = uf
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?){
        moneyInput.resignFirstResponder()
        moneyInputEuro.resignFirstResponder()
        UFInput.resignFirstResponder()
        
        /*para que al apretar la pantalla dsps de poner el input se vaya el teclado de numeros */
        
    }
    
//--------------------------------------------------------------
    
    // Money Convertions
    
    func convertDoubleToCurrency(input: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "es_CL")
        
        return numberFormatter.string(from: NSNumber(value: input))!
    }
    
    /*Cambias el identifier con la lista de cada pais, pones .currency para paises extranjeros (aparece el simbolo Yen por ejemplo) */
    
    func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "es_CL")
        
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    
    //DOLAR, EURO, YEN, ETC...
    
    func convertMoney(input:UITextField, X:Double, ArrayCount : Int)-> Double {
        let x = input.text
        let xModified = x!.replacingOccurrences(of: ",", with: ".")
        let xModifiedDouble = Double (xModified)
        //esto es solo valido para los paises con SI, en caso contrario va a colapsar (se debe reemplazar la coma por el punto o bien detectar el pais (posble bug)
        
        //Array count es el Array correspondiente a la divisa y el .count
        
        if ArrayCount > 0 && xModifiedDouble != nil{
            let clp = xModifiedDouble!*X
            let clp2 = round(clp*1000)/1000
            return clp2
        }
        if ArrayCount == 0 && xModifiedDouble != nil  {
            let clp = xModifiedDouble!*X
            let clp2 = round(clp*1000)/1000
            return clp2
            
        }else{
            let clp = 0.0
            return clp
            
        }
        
    }
    
    func convertMoneyInverse(input:UITextField, X: Double, ArrayCount: Int)-> Double{
        let x = input.text
        let xModified = x!.replacingOccurrences(of: ",", with: ".")
        let xModifiedDouble = Double (xModified)
        
        if ArrayCount > 0 && xModifiedDouble != nil {
            let usd = xModifiedDouble!/X
            let usd2 = round(usd*1000)/1000
            return usd2
            
        }
        if ArrayCount == 0 && xModifiedDouble != nil  {
            let usd = xModifiedDouble!/X
            let usd2 = round(usd*1000)/1000
            return usd2
            
        }else{
            let usd = 0.0
            return usd
            
        }
        
    }
    /* Se usa usd, pero corresponde al identificador Foreign Money */
    
    func unisexMoneyconvertion(input: UITextField, X:Double,  ArrayCount: Int, tapCountIdentifier: Int) -> Double{
        
        if (tapCountIdentifier) % 2 == 0 { //el numero es par
            
            return convertMoney(input: input, X: X, ArrayCount: ArrayCount)
            
        }else if (tapCountIdentifier) % 2 != 0 { //el numero es impar
            return convertMoneyInverse(input: input ,X: X , ArrayCount: ArrayCount)
            
        }
        return unisexMoneyconvertion(input: input,X: X, ArrayCount: ArrayCount, tapCountIdentifier: tapCountIdentifier)
        
    }
    
    //
    
    //UF
    
    func ufPriceConvertion(input: UITextField) -> Double {
        let y = input.text
        let yModified = y!.replacingOccurrences(of: ",", with: ".")
        let yModifiedDouble = Double (yModified)
        
        if yModifiedDouble != nil  {
            let UF = yModifiedDouble!*infoUFArray[0]
            let UF2 = round(UF*1000)/1000
            return UF2
            
        }else{
            let UF = 0.0
            return UF
        }
        
        
    }
    // -------------------------------------------------------------------
    
    //SWITCHERS
    
    //Para Voltear el orden de conversion
    
    var tapCountUSD = [Int]()
    var x = 0
    
    func buttonTapped(x:Int) {
        let x = x+1
        tapCountUSD.append(x)
    }
    
    //DOLAR
    @IBOutlet weak var USDLabel: UILabel!
    
    @IBOutlet weak var CLPLabel: UILabel!
    
    @IBAction func switcher(_ sender: UIButton) {
        
        buttonTapped(x: x)
        
        //DOLAR
        moneyInput.text = ""
        moneyOutputLabel.text = ""
        moneySymbolDolar.text = "$"
        
        
        print (tapCountUSD.count-1)
        
        if (tapCountUSD.count) % 2 == 0 { //el numero es par
            
            //DOLAR
            USDLabel.text = "USD"
            CLPLabel.text = "CLP"
            
     
        }
        
        if (tapCountUSD.count) % 2 != 0 { //el numero es impar
            
            //DOLAR
            USDLabel.text = "CLP"
            CLPLabel.text = "USD"
            
        }
        
    }
    
    //EURO
    
    @IBOutlet weak var EURLabel: UILabel!
    
    @IBOutlet weak var CLP_EuroLabel: UILabel!
    
    var tapCountEUR = [Int]()
    var y = 0
    
    func buttonTapped2(y:Int) {
        let y = y+1
        tapCountEUR.append(y)
    }
    
    @IBAction func switcherEuro(_ sender: UIButton) {
        
        buttonTapped2(y: y)
        
        //EURO
        moneyInputEuro.text = ""
        moneyOutputLabelEuro.text = ""
        moneySymbolEuro.text = "€"
        
        
        print (tapCountEUR.count-1)
        
        if (tapCountEUR.count) % 2 == 0 { //el numero es par
            
            EURLabel.text = "EUR"
            CLP_EuroLabel.text = "CLP"
            
            
            
            moneySymbolLeftBox.text = "€"
            
            moneySymbolEuro.text = "$"
        }
        
        if (tapCountEUR.count) % 2 != 0 { //el numero es impar
            
            EURLabel.text = "CLP"
            CLP_EuroLabel.text = "EUR"
            
            moneySymbolLeftBox.text = "$"
            
        }
    }
    
    
    //------------------------------------------------------------
    
    @IBOutlet weak var moneyInput: UITextField!
    
    @IBOutlet weak var moneyOutputLabel: UILabel!
    
    @IBOutlet weak var labelPriceDisplay: UILabel! //Label display of Prices/Value (instead of table view)
    
    @IBOutlet weak var moneySymbolDolar: UILabel!
    
    
    var infoDolarArray = [Double]()

    //infoDolarArray[0] te dara el Double del dolar, que luego se transforma en String con coma
    
    
    
    func downloadJsonUsingURL() {
        
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
        
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //print(jsonObj!.value(forKey: "Dolares"))
                
                if let dolarArray = jsonObj!.value(forKey: "Dolares") as? NSArray {
                    for dolar in dolarArray{
                        if let valoresDict = dolar as? NSDictionary {
                            if let precioDelDolar = valoresDict.value(forKey: "Valor") {
                                //print ("search: \(precioDelDolar)")
                                
                                
                                let x = precioDelDolar as! String
                                let modifiedx = x.replacingOccurrences(of: ",", with: ".")
                                let xDouble = Double(modifiedx)
                                
                                self.infoDolarArray.append(xDouble as! Double)
                                
                                if x != "" {
                                    UserDefaults.standard.set(self.infoDolarArray[0], forKey: "valorDelDolar")
                                }
                                
                                print (self.infoDolarArray)
                                print(self.infoDolarArray.count)
                                
                                
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
    
    
    //TABLE VIEW
    
    //Se usa el table view para los labels ya que por el momento es lo unico que se carga dsps del viewDidLoad (se hizo muy pequeñito para que no se viera
    
    /*BUSCA COMO ELIMINAR EL TABLE VIEW!! (YO NO SE NECESITA PARA SER USADO (ver el caso de la UF) */
    
    @IBOutlet weak var moneyTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoDolarArrayChile.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moneyTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let modifiedxToSI = String(infoDolarArrayChile[0])
        let modifiedxToSIComa = modifiedxToSI.replacingOccurrences(of: ".", with: ",")
        
        cell.moneyLabel.text = ("$ \(modifiedxToSIComa)")
      //  labelPriceDisplay.text = cell.moneyLabel.text
     //   moneyOutputLabel.text = ("\(modifiedxToSIComa)")
        
        
        
        //para lo de los viernes puedes usar la fecha o ver algo que te de nil
        
        return cell
    }
    
    
    
    
    
    //--------------------------------------------------------------------------------
    
    //EURO
    
    
    @IBOutlet weak var moneyInputEuro: UITextField!
    
    @IBOutlet weak var moneyOutputLabelEuro: UILabel!
    
    @IBOutlet weak var labelPriceDisplayEuro: UILabel!
    
    @IBOutlet weak var moneySymbolEuro: UILabel!
    
    @IBOutlet weak var moneySymbolLeftBox: UILabel!
    
    
    var infoEuroArray = [Double]()

    
    
    func downloadEuroJsonUsingURL() {
        
        let calendar = Calendar.current
        let today = Date()
        
        var urlStringEuro = ""

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
            
            urlStringEuro = "https://api.sbif.cl/api-sbifv3/recursos_api/euro/\(year)/\(month)/dias/\(day)?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"
        }
        else {
            
            urlStringEuro = "https://api.sbif.cl/api-sbifv3/recursos_api/euro?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"
        }
        
        
        
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
                                
                                self.infoEuroArray.append(xDouble as! Double)
                                
                                if x != "" {
                                    UserDefaults.standard.set(self.infoEuroArray[0], forKey: "valorDelEuro")
                                }
                                
                                print (self.infoEuroArray)
                                print(self.infoEuroArray.count)
                                
                                
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
    
    //-----------------------------------------------------------
    
    //UF
    
    //La UF se actualiza TODOS los Dias
    
    @IBOutlet weak var labelPriceDisplayUF: UILabel!
    
    @IBOutlet weak var UFInput: UITextField!
    
    @IBOutlet weak var UFInputAmountLabel: UILabel!
    
    @IBOutlet weak var UFLabel: UILabel!
    
    @IBOutlet weak var arrowLabel: UILabel!
    
    @IBOutlet weak var UFOutputLabel: UILabel!
    
    @IBOutlet weak var moneySymbolUF: UILabel!
    
    
    var infoUFArray = [Double]()
    
    //infoDolarArray[0] te dara el Double del dolar, que luego se transforma en String con coma
    
    final let urlStringUF = "https://api.sbif.cl/api-sbifv3/recursos_api/uf?apikey=a9bd585284817d43ce4baafdcd7948a465641d5e&formato=json"
    
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
                                
                                self.infoUFArray.append(xDouble as! Double)
                                
                                if x != "" {
                                    UserDefaults.standard.set(self.infoUFArray[0], forKey: "valorUF")
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
    
    
    
    //IMAGENES
    
    @IBOutlet var imagenLetrasDolar: UIImageView!
    
    @IBOutlet var imagenLetrasEuro: UIImageView!
    
    @IBOutlet var imagenLetrasUF: UIImageView!
    
   
    
    
}

//Falta agregar el euro con su location y la transformacion unisex arreglada
//Pon la conversion Nuevo Sol peruano a USD, y luego de USD a CLP
/*Recuerda poner las referencias de donde sacas la informacion y que los valores corresponden a la COMPRA, por ende siempre seran menores a los valores de venta de las divisas*/
/*Todo lo que se use para las conversiones de chile mantenlo textual en esta hoja, para el resto de los paises crea nuevos FILES con la informacion correspondiente a cada banco central para dsps solo llamarla*/


//arregla el hecho de que al voltear con el switcher se calcula en ambos lados
