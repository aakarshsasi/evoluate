//
//  categoriesViewController.swift
//  evoluate
//
//  Created by Aakarsh S on 03/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Toast_Swift

class categoriesViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {
    @IBOutlet weak var categoriesCarousel: iCarousel!
    @IBOutlet weak var buttonView: UIView!

    @IBOutlet weak var timelineButton: UIButton!
    var imageSet=[UIImage(named: "amphibians"),UIImage(named:"bird"),UIImage(named:"fish"),UIImage(named:"mammals"),UIImage(named:"premammals"),UIImage(named:"reptiles")]
    var imageWorkshop: [String] = []
    
//    let speciesName=["Machine Learning", "Cyber Security","UI UX","Blockchain","Cloud Computing"]
    var speciesName: [String] = []
    var kingdomSpecies:[String]=[]
    var speciesDesc:[String]=[]
    var phylumName:[String]=[]
 
  
   
    

    
    let custGreen : UIColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // FIXME: Remove code below if u're using your own menu
        setupNavForDefaultMenu()
        
        // Add left bar button item
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "burger"), style: .plain, target: self, action: #selector(toggleSideMenu))
        navigationItem.leftBarButtonItem = leftBarItem
        
       
        
        
        title = "Categories"
        
    }
    private func setupNavForDefaultMenu() {
        // Revert navigation bar translucent style to default
        navigationBarNonTranslecentStyle()
        // Update side menu after reverted navigation bar style
        sideMenuManager?.instance()?.menu?.isNavbarHiddenOrTransparent = false
        navigationItem.hidesBackButton = true
    }
    
    @objc func toggleSideMenu() {
        sideMenuManager?.toggleSideMenuView()
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return  imageWorkshop.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView=UIView(frame: CGRect(x: 0, y: 0, width: 200 , height: 200))
        tempView.backgroundColor=UIColor.white
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: tempView.frame.size.width-20, height: tempView.frame.size.height-20))
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.center = CGPoint(x: tempView.frame.size.width  / 2,
                                   y: tempView.frame.size.height / 2)
        
        imageView.image = UIImage(named: imageWorkshop[index])
        imageView.layer.cornerRadius=20
        tempView.layer.cornerRadius=20
        tempView.addSubview(imageView)
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option==iCarouselOption.spacing{
            return value*3
        }
        return value
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCarousel.type = .rotary
        categoriesCarousel.decelerationRate=0.3
        speakerView.isHidden=false
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(true)
        ref.child("Categories").observeSingleEvent(of: .value) { (snapshot) in
            //getting names 
            let value = snapshot.value as? NSDictionary
            self.speciesName = value?.allKeys as! [String]
            self.speciesName = self.speciesName.sorted()
            //getting details
            for name in self.speciesName
            {
                ref.child("Categories").child(name).observeSingleEvent(of: .value) { (snapshot1) in
                    
                    let value1 = snapshot1.value as? NSDictionary
                    self.phylumName.append(value1?["phylum"] as! String)
                    self.kingdomSpecies.append(value1?["kingdom"] as! String)
                    self.speciesDesc.append(value1?["description"] as! String)
                    
             
                    self.imageWorkshop.append(value1?["image"] as! String)
                    if self.phylumName.isEmpty{
                        return
                    }else{
                        self.categoryKingdom.text=self.phylumName[0]
                        self.categoryName.text=self.speciesName[0]
                        
                        self.categoryClass.text=self.kingdomSpecies[0]
                        
                        
                        self.categoryImage.image=self.imageSet[0]
                        self.descriptionCat.text=self.speciesDesc[0]
                        
                        
                           self.speakerView.isHidden=false
                        }
                        
                    
                    self.categoriesCarousel.reloadData()
                    
                    
                    
                    
                   
                }
                
                
            }
         
            
                    }
   
     
        
        // Do any additional setup after loading the view.
        categoriesCarousel.isPagingEnabled=true
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = custGreen.cgColor
       
        self.navigationItem.rightBarButtonItem?.accessibilityElementsHidden=true
        
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print(categoriesCarousel.currentItemIndex)
       
        if self.phylumName.isEmpty{
            return
        }else{
        
        categoryName.text=speciesName[categoriesCarousel.currentItemIndex]
        categoryClass.text=kingdomSpecies[categoriesCarousel.currentItemIndex]
        descriptionCat.text=speciesDesc[categoriesCarousel.currentItemIndex]
            categoryImage.image=UIImage(named: imageWorkshop[categoriesCarousel.currentItemIndex])
            timelineButton.tag=categoriesCarousel.currentItemIndex
            timelineButton.addTarget(self, action: #selector(categories), for: .touchUpInside)
       

        categoryKingdom.text=phylumName[categoriesCarousel.currentItemIndex]
          
            
        
        }
    }
    @IBAction func categories(_ sender: Any) {
       
        
        self.performSegue(withIdentifier: "timelineView", sender: self)
        
      
        
        
    }

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryClass: UILabel!
    @IBOutlet weak var categoryKingdom: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var descriptionCat: UITextView!
    

    
    
    @IBAction func nextButton(_ sender: Any) {
       
       categoriesCarousel.currentItemIndex=(categoriesCarousel.currentItemIndex+1)%6
    
        
    }
    @IBOutlet weak var speakerView: UIView!
    
    @IBAction func backButton(_ sender: Any) {
         categoriesCarousel.currentItemIndex=(categoriesCarousel.currentItemIndex-1)%6
        
    }
   
    
    
  
   
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier=="timelineView"{
            
        
        let nowPlayingView = segue.destination as! ChildViewController4
        nowPlayingView.titleString="\(categoriesCarousel.currentItemIndex)"
            nowPlayingView.titleOfThePage=speciesName[categoriesCarousel.currentItemIndex]
        }
        

}
}
