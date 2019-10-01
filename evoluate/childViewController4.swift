//
//  ChildViewController1.swift
//  testest
//
//  Created by Aakarsh S on 07/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit


class ChildViewController4: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var events:[String]=[]
    var nameSpecies:[String] = []
    var descriptionString:[String] = []
    var titleString: String!
    var titleOfThePage: String!
    var searchResults:[String] = []
    var searching=false
   
    var period:[String]=[]
    @IBOutlet weak var collectionDay4: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchFirebaseData()
        setupNavForDefaultMenu()
        
      
        self.view.makeToast("Tap on any cell to view in detail")
        title = titleOfThePage
        
        let leftBarItem = UIBarButtonItem(title: "<Categories", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))

        
        
        navigationItem.leftBarButtonItem = leftBarItem
        
    }
    
    
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
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
    
    func fetchFirebaseData(){
        (UIApplication.shared.delegate as! AppDelegate).ref1.child("timelineIOS").child(titleString).observe(.value) { (snapshot) in
            let value=snapshot.value as? NSDictionary
            
            self.events=value?.allKeys as! [String]
            self.events = self.events.sorted()
            
            for name in self.events
            {
                (UIApplication.shared.delegate as! AppDelegate).ref1.child("timelineIOS").child(self.titleString).child(name).observe(.value, with: { (snapshot1) in
                    let value1 = snapshot1.value as? NSDictionary
                    
                    self.nameSpecies.append(value1?["name"] as! String)
                    self.period.append(value1?["time"] as! String)
                    self.descriptionString.append(value1?["desc"] as! String)
                    
                    
                    
                    
                    (UIApplication.shared.delegate as! AppDelegate).ref1.keepSynced(true)
                    print(self.nameSpecies)
                    self.collectionDay4.reloadData()
                    
                })
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching==false{
            return nameSpecies.count
        }
        else{
            return searchResults.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID1", for: indexPath) as! scheduleCollectionViewCell
        if(searching==true){
            cell.eventTitle.text?=searchResults[indexPath.row]
        }
        else{
            cell.eventTitle.text?=nameSpecies[indexPath.row]
             cell.eventTiming.text?=period[indexPath.row]
            
        }
        
      
       
        //This creates the shadows and modifies the cards a little bit
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        
        cell.layer.masksToBounds = false
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.allowsMultipleSelection = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "popupViewController") as! PopupViewController
        vc.titleString = nameSpecies[indexPath.row]
        vc.descString = descriptionString[indexPath.row]
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
        
        
    }
  
   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension ChildViewController4:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults=nameSpecies.filter({$0.prefix(searchText.count)==searchText})
        searching=true
        
        collectionDay4.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching=false
        collectionDay4.reloadData()
    }
}
