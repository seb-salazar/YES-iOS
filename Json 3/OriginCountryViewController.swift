//
//  OriginCountryViewController.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/9/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import UIKit

//RECUERDA SIEMPRE MODIFICAR LOS INTERVALOS SI ES QUE AGREGAS BANDERAS

var lastPositionVC1 = Int()


var countriesPositionsVC1 = [Int:String]()
//para tener nocion al ver lastpositions de que pais fue elegido, y elegir la denominacion "es_CL" por ejemplo y el tipo de cambio
//la posicion de cada numero se mantiene cte a traves de TODOS los VC



var countriesPositionsReference = [0:"argentina", 1:"chile", 2:"peru", 3:"uk", 4:"italia", 5:"japon", 6:"usa"]


//a medida que se suman paises los agregas en estos dos arrays solamente, junto con sus imagenes en la carpeta de Assets
var countriesImages = ["argentina", "chile", "peru", "uk", "italia", "japon", "usa"]
var countriesLabels = ["Argentina", "Chile", "Peru", "UK", "Italia", "Japon", "USA"]






//el navigation controller sirve para ahorrarse todos los segues



var removedOrigin = Int()
var removedDestination = Int()





class OriginCountryViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    var slides:[Slide] = [];
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar
        //var navigationBarAppearace = UINavigationBar.appearance()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //--------------------------
        
       
        
        scrollView.delegate = self
        
        
        
        slides = createSlides()
        
        
        
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        
        
        lastPositionVC1 = 0
        print("lastPositionVC1 = \(lastPositionVC1)")
        //para que lo primero que aparezca es la posicion 0 solo la primera vez, pq el scroll dsps va a determinar la posicion 0
        
        
        
        //To perform the segue without a button from uiview and to Select a country using GESTURES
        //like an invisible button
        
        // object of subclass
        //a rectangle width 20, right in the middle
        let customView = Slide(frame: CGRect(x: 137.5, y: 0, width: 100, height: 600))
        //adding it to ViewController
        self.view.addSubview(customView)
        
        // instantiate the object of gesture recognizer
        let gestureRec = UITapGestureRecognizer(target: self, action:  #selector (self.someAction))
        //add it to custom view
        customView.addGestureRecognizer(gestureRec)
        
        
        if Locale.current.identifier == "en_CL" {
            
            //the default when coding because of the project language
            //change it to the spanish speaking countries identifiers
            
            self.title = ""
            
            //Para que el back button no tenga titulo o tenga otro
            let backButton = UIBarButtonItem(title: español["vcMainMenuTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            
            questionLabel.text = español["vcOriginQuestion"]
            
  
        }
        else {
            self.title = ""
            
            //Para que el back button no tenga titulo o tenga otro
            let backButton = UIBarButtonItem(title: english["vcMainMenuTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            
            questionLabel.text = english["vcOriginQuestion"]
        }
        
        
        
    }
    
    
    //to perform the segue without button
    //you need a storyboard ID
    
    
    
    
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        /*
         let controller = storyboard?.instantiateViewController(withIdentifier: "ViewController2")
         self.present(controller!, animated: true, completion: nil)
         */ //to use a segue without a button and a navigation view controller
        
        
        //when using navigation vie controller,for the navigation bar to work
        performSegue(withIdentifier: "origin->destination", sender: self)
        var x = Int()
        
        for i in 0..<slides.count {
            if i == lastPositionVC1 {
                countriesImages.remove(at: i)
                
                countriesLabels.remove(at: i)
                
                x = i
                
                print("removed \(x)")
                //recuerda que se vuelven a reordenar
                //debes conocer las posiciones originales y los numeros reasignados
                
                removedOrigin = x
                
                
            }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Slides remaining : \(slides.count)")
        
        
        
        
        
        
        //for refresh
        countriesImages = ["argentina", "chile", "peru", "uk", "italia", "japon", "usa"]
        countriesLabels = ["Argentina", "Chile", "Peru", "UK", "Italia", "Japon", "USA"]
        
        //debesArreglar esto para que coincida con el idioma, el refresh interno puede ser en el idioma que tu quieras, pero el externo debe coincidir con el Locale ID
        
        
        slides = createSlides()
        //es importante que las slides se creen dsps del refresh de los arrays
        
        
        //basta que funcione con un array
        for i in 0..<countriesImages.count{
            
            countriesPositionsVC1[i] = countriesImages[i]
            //dict["key"] = "value"
            
        }
        print(countriesPositionsVC1)
        
    }
    
    
    
    
    func createSlides() -> [Slide] {
        
        var array:[Slide] = []
        
        //basta con que un array se cumpla
        for i in 0..<countriesImages.count {
            
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.imageView.image = UIImage(named: countriesImages[i])
            slide.labelTitle.text = countriesLabels[i]
            
            
            //IDs
//            if Locale.current.identifier == "en_US" {
//
//                //the default when coding because of the project language
//                //change it to the spanish speaking countries identifiers
//
//                slide.questionLabel.text = español["vcOriginQuestion"]
//
//
//            }
            
            
            array.append(slide)
            
        }
        
        return array
        
    }
    
    
    
    
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 151, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        
        
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
            
        }
        
        
    }
    
    
    
    /*
     * default function called when view is scrolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        //for disabling the vertical scroll
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        

        
        //vas a tener que agregar a mano los intervalos dependiendo del numero de banderas

        if scrollView.contentOffset.x == 0 {


            lastPositionVC1 = 0
            print("lastPositionVC1 = \(lastPositionVC1)")

        } else if scrollView.contentOffset.x < 0 {


            lastPositionVC1 = 0
            print("lastPositionVC1 = \(lastPositionVC1)")

        } else if(percentOffset.x > 0 && percentOffset.x <= 1/6) {

            slides[0].imageView.transform = CGAffineTransform(scaleX: (1/6 - percentOffset.x) / 1/6, y: (1/6 - percentOffset.x) / 1/6)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x / 1/6, y: percentOffset.x / 1/6 )


            lastPositionVC1 = 1
            print("lastPositionVC1 = \(lastPositionVC1)")


        } else if(percentOffset.x > 1/6 && percentOffset.x <= 2/6) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (2/6 - percentOffset.x) / 1/6, y: (2/6 - percentOffset.x) / 1/6)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x / 2/6, y: percentOffset.x / 2/6)


            lastPositionVC1 = 2
            print("lastPositionVC1 = \(lastPositionVC1)")

        } else if(percentOffset.x > 2/6 && percentOffset.x <= 3/6) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (3/6 - percentOffset.x) / 1/6, y: (3/6 - percentOffset.x) / 1/6)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x / 3/6, y: percentOffset.x / 3/6)


            lastPositionVC1 = 3
            print("lastPositionVC1 = \(lastPositionVC1)")

        } else if(percentOffset.x > 3/6 && percentOffset.x <= 4/6) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (4/6 - percentOffset.x) / 1/6, y: (4/6 - percentOffset.x) / 1/6)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x / 4/6, y: percentOffset.x / 4/6)


            lastPositionVC1 = 4
            print("lastPositionVC1 = \(lastPositionVC1)")

        
        } else if(percentOffset.x > 4/6 && percentOffset.x <= 5/6) {
            slides[4].imageView.transform = CGAffineTransform(scaleX: (5/6 - percentOffset.x) / 1/6, y: (5/6 - percentOffset.x) / 1/6)
            slides[5].imageView.transform = CGAffineTransform(scaleX: percentOffset.x / 5/6, y: percentOffset.x / 5/6)
            
            
            lastPositionVC1 = 5
            print("lastPositionVC1 = \(lastPositionVC1)")
            
            
        } else if(percentOffset.x > 5/6 && percentOffset.x <= 1) {
            slides[5].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x) / 1/6, y: (1-percentOffset.x) / 1/6)
            slides[6].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            
            
            lastPositionVC1 = 6
            print("lastPositionVC1 = \(lastPositionVC1)")
            
            
        }
        
        
        
        
        //es como los quintiles y los cuartiles, si hay 5 paises (quintiles), se divide 1/4
        
        //---> la formula es :   1/(nº de paises - 1)   para los limites de los intervalos
        
        // asi mismo el numero de condiciones (else if's dejando de lado la del cero, que va siempre) es = ( nº de paises - 1 ). e.g: si hay 5 paises, deben haber 4 else if's ademas el que involucra a la posicion 0
        
        
        
        
        
        
        
        
        
        
        
        
        
        //basta que funcione con un array
        
        
        
//        for i in 0..<(countriesImages.count - 1) {
//
//
//            if scrollView.contentOffset.x == 0 {
//
//
//                lastPositionVC1 = 0
//                print("lastPositionVC1 = \(lastPositionVC1)")
//
//            } else if scrollView.contentOffset.x < 0 {
//
//
//                lastPositionVC1 = 0
//                print("lastPositionVC1 = \(lastPositionVC1)")
//
//
//            } else if percentOffset.x >  1/(countriesImages.count - 1) + (i - 1)/(.count - 1)  && percentOffset.x <=  1/(countriesImages.count - 1) + i/(countriesImages.count - 1)  {
//
//
//                //                slides[i].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//                //                slides[i+1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//
//                lastPositionVC1 = i+1
//                print("lastPositionVC1 = \(lastPositionVC1)")
//
//
//            }
//
//        }
        
        
        //cool idea, doesnt work--> esta es la logica para setear intervalos
        
        
        // for i in 0..<(countriesImages.count - 1)
        
        //percentOffset.x >  1/(countriesImages.count - 1) + (i - 1)/(.count - 1)  && percentOffset.x <=  1/(countriesImages.count - 1) + i/(countriesImages.count - 1)
        
        

            
            
    
        
        
        
        
        
        
        
        
        
        
        
    
    
    
//    1-1, 1-3/4 x , 1-2/4 x, 1-1/4 x , 1
//
//    0, 0+1/4, 0+2/4, 0+3/4, 0+4/4
//
//    0, 0+1/3, 0+2/3, 0+3/3
    
    
    
    
    
    
    
    
    //buttons
    
    
    
    
    
    
   }


}
