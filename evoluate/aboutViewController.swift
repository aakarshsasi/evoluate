//
//  evoluate
//
//  Created by Aakarsh S on 05/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import WebKit
import Firebase
class aboutViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var comboName: [String] = []
    var comboPrice:[String]=[]
    var comboDescription:[String]=[]
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height-200)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // FIXME: Remove code below if u're using your own menu
        setupNavForDefaultMenu()
        
        // Add left bar button item
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "burger"), style: .plain, target: self, action: #selector(toggleSideMenu))
        navigationItem.leftBarButtonItem = leftBarItem
        
        title = "About Me"
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walkThroughIdentifier", for: indexPath) as! aboutCollectionViewCell
        cell.comboTitle.text=self.comboName[indexPath.row]
        if self.comboDescription.isEmpty==false{
            cell.comboDescription.text=self.comboDescription[indexPath.row]
            
            cell.comboPrice.text=self.comboPrice[indexPath.row]
            
            cell.viewButton.tag=indexPath.row
            cell.viewButton.addTarget(self, action: #selector(linkedin), for: .touchUpInside)
        }
        
        return cell
    }
    @IBOutlet weak var walkThroughCollectionView: UICollectionView!
    
    @objc func linkedin(_ sender: UIButton){
        
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webViewController") as! webViewController
       
       nextViewController.title="My Instagram"
      self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        var ref:DatabaseReference
        ref = Database.database().reference()
        walkThroughCollectionView.register(UINib.init(nibName: "aboutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "walkThroughIdentifier")
        let flowlayout=UPCarouselFlowLayout()
        flowlayout.itemSize=CGSize(width: UIScreen.main.bounds.size.width-60.0, height: walkThroughCollectionView.frame.size.height)
        flowlayout.scrollDirection = .horizontal
        flowlayout.sideItemScale=0.8
        flowlayout.sideItemAlpha=1.0
        flowlayout.spacingMode = .fixed(spacing: 5.0)
        walkThroughCollectionView.collectionViewLayout=flowlayout
        walkThroughCollectionView.delegate=self
        walkThroughCollectionView.dataSource=self
        //firebase
        
        ref.child("about").observe(.value) { (snapshot) in
            let value=snapshot.value as?NSDictionary
            
            self.comboName=value?.allKeys as! [String]
            self.comboName=self.comboName.sorted()
            for name in self.comboName
            {
                ref.child("about").child(name).observe(.value, with: { (snapshot1) in
                    let value1 = snapshot1.value as? NSDictionary
                    self.comboPrice.append(value1?["caption"] as! String)
                    self.comboDescription.append(value1?["longDescription"] as! String)
                 
                    ref.keepSynced(true)
            self.walkThroughCollectionView.reloadData()
                })
            }
         
        }
        
        
        
        
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  comboPrice.count
    }
    
    
    
    
    @IBAction func webViewHere(_ sender: Any) {
        

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

      
       
        
       
//
    }
    
}





/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

