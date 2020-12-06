//
//  DestinationCountryViewController.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 1/9/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import UIKit


var lastPositionVC2 = Int()


var countriesPositionsVC2 = [Int:String]()
//para tener nocion al ver lastpositions de que pais fue elegido, y elegir la denominacion "es_CL" por ejemplo y el tipo de cambio
//la posicion de cada numero se mantiene cte a traves de TODOS los VC


var countriesImagesCopy = [String]()

var countriesLabelsCopy = [String]()





class DestinationCountryViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    var slides:[Slide] = [];
    
    
    var countriesImagesCopy2 = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigation bar
        //var navigationBarAppearace = UINavigationBar.appearance()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //-----------------------
        
        
        
        
        scrollView.delegate = self
        
        
        countriesImagesCopy = countriesImages
        
        countriesLabelsCopy = countriesLabels
        
        
        
        slides = createSlides()
        
        
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        
        
        
        
        
        lastPositionVC2 = 0
        print("lastPositionVC2 = \(lastPositionVC2)")
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
            let backButton = UIBarButtonItem(title: español["vcOriginTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            questionLabel.text = español["vcDestinationQuestion"]
            
        }
        else {
            self.title = ""
            
            //Para que el back button no tenga titulo o tenga otro
            let backButton = UIBarButtonItem(title: english["vcOriginTitle"], style: .plain, target: self, action: Selector(("backBtnClicked")))
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            
            questionLabel.text = english["vcDestinationQuestion"]
        }
        
        
        
    }
    
    
    //to perform the segue without button
    //you need a storyboard ID
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    
    
    
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        /*
         let controller = storyboard?.instantiateViewController(withIdentifier: "ViewController2")
         self.present(controller!, animated: true, completion: nil)
         */ //to use a segue without a button and a navigation view controller
        
        
        //when using navigation vie controller,for the navigation bar to work
        performSegue(withIdentifier: "destination->converter", sender: self)
        var x = Int()
        
        //se pone el +1 ya que tiene una slide menos
        for i in 0..<slides.count + 1  {
            if i == lastPositionVC2 {
                
                //para determinar que posicion fue la eliminada en el VC2, ya que las posiciones se mantienen ctes en todos los VC
                
                countriesImagesCopy2.remove(at: i)
            
                
                x = i
                
                print("removed \(x)")
                //recuerda que se vuelven a reordenar
                //debes conocer las posiciones originales y los numeros reasignados
                
                removedDestination = x
                
                //
            }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        lastPositionVC2 = 0
        print("lastPositionVC2 = \(lastPositionVC2)")
        //para que lo primero que aparezca es la posicion 0 solo la primera vez, pq el scroll dsps va a determinar la posicion 0
        
        
        //for refresh
        //a copy its fundamental for everything to work properly
        
        countriesImagesCopy = countriesImages
        
        countriesLabelsCopy = countriesLabels
        
        //
        
        //for refresh
        countriesImagesCopy2 = ["argentina", "chile", "peru", "uk", "italia", "usa"]
        

        
        for i in 0..<countriesImages.count{
            
            countriesPositionsVC2[i] = countriesImages[i]
            //dict["key"] = "value"
            
        }
        print(countriesPositionsVC2)
        
        
        stopTimer()
        //for the program not to collapse if a json fails or throws nil
        
    }
    
    
    
    func createSlides() -> [Slide] {
        
        var array:[Slide] = []
        
        //basta con que un array se cumpla
        for i in 0..<countriesImagesCopy.count {
            
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.imageView.image = UIImage(named: countriesImagesCopy[i])
            slide.labelTitle.text = countriesLabelsCopy[i]
            
            //IDs
//            if Locale.current.identifier == "en_US" {
//
//                //the default when coding because of the project language
//                //change it to the spanish speaking countries identifiers
//
//                slide.questionLabel.text = español["vcDestinationQuestion"]
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
        
        
        
        if scrollView.contentOffset.x == 0 {
            
            //            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            //            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
            lastPositionVC2 = 0
            print("lastPositionVC2 = \(lastPositionVC2)")
            
        } else if scrollView.contentOffset.x < 0 {
            
            
            //            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            //            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
            lastPositionVC2 = 0
            print("lastPositionVC2 = \(lastPositionVC2)")
            
        } else if(percentOffset.x > 0 && percentOffset.x <= 1/5) {
            
            //            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.33-percentOffset.x)/0.33, y: (0.25-percentOffset.x)/0.33)
            //            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
            
            
            
            lastPositionVC2 = 1
            print("lastPositionVC2 = \(lastPositionVC2)")
            
            
        } else if(percentOffset.x > 1/5 && percentOffset.x <= 2/5) {
            
            
            //            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
            //            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.66, y: percentOffset.x/0.66)
            
            
            
            lastPositionVC2 = 2
            print("lastPositionVC2 = \(lastPositionVC2)")
            
        } else if(percentOffset.x > 2/5 && percentOffset.x <= 3/5) {
            //            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.99-percentOffset.x)/0.33, y: (0.99-percentOffset.x)/0.33)
            //            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.99, y: percentOffset.x/0.99)
            
            
            
            lastPositionVC2 = 3
            print("lastPositionVC2 = \(lastPositionVC2)")
            
            //el scroll del VC2 tiene 1 menos que el del VC1 --> Denominador = (nº paises - 2)
            
        } else if(percentOffset.x > 3/5 && percentOffset.x <= 4/5) {
            //            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.99-percentOffset.x)/0.33, y: (0.99-percentOffset.x)/0.33)
            //            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.99, y: percentOffset.x/0.99)
            
            
            
            lastPositionVC2 = 4
            print("lastPositionVC2 = \(lastPositionVC2)")
            
            //el scroll del VC2 tiene 1 menos que el del VC1 --> Denominador = (nº paises - 2)
            
        } else if(percentOffset.x > 4/5 && percentOffset.x <= 5/5) {
            //            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.99-percentOffset.x)/0.33, y: (0.99-percentOffset.x)/0.33)
            //            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.99, y: percentOffset.x/0.99)
            
            
            
            lastPositionVC2 = 5
            print("lastPositionVC2 = \(lastPositionVC2)")
            
            //el scroll del VC2 tiene 1 menos que el del VC1 --> Denominador = (nº paises - 2)
            
        }
        
        
        
        
    }
    
    
    //las animaciones dependen de los numeros, por ejemplo si hay 5 slides se divide por 0.25, si haces bien el calculo puedes hacer que tenga animacion
    
    
    
    //no es que sea una posicion global, sino que se salta la posicion 1 siempre en el destiantion debido a los limites (como cuartiles) seteados
    //es por eso que debes crear una funcion recursiva que determine los puntos y limites en base a los paises que se van agregando
    
    //ademas debes volver a crear los countries positions para cada VC y con esos trabajar en base a los origin y destination removed
    
    
    //buttons
    
    
    
    
    
    
}











/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


