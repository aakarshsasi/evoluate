//
//  profileViewController.swift
//  evoluate
//
//  Created by Aakarsh S on 22/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class profileViewController: UIViewController {
   let defaults = UserDefaults.standard
    
    
  
    
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
    
 
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
  

    @IBOutlet weak var phoneNo: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profilePicture.layer.shadowColor = UIColor.gray.cgColor
        profilePicture.layer.shadowOpacity = 0.8
        profilePicture.layer.shadowOffset = CGSize.zero
        profilePicture.layer.shadowRadius = 5
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.layer.borderWidth = 2
        profilePicture.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
        
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "qr-code"), style: .plain, target: self, action: #selector(qrbutton))
        rightBarItem.tintColor=UIColor.black
        self.navigationItem.rightBarButtonItem = rightBarItem
      
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(profileViewController.selectImage))
        profilePicture.addGestureRecognizer(tapGesture)
      profilePicture.isUserInteractionEnabled=true
        mobileView.layer.shadowColor = UIColor.gray.cgColor
        mobileView.layer.shadowOpacity = 0.8
        mobileView.layer.shadowOffset = CGSize.zero
        mobileView.layer.shadowRadius = 5
        mobileView.layer.cornerRadius = mobileView.frame.size.height/2
        
        if UserDefaults.standard.string(forKey: "name") != nil{
       
           
            
            nameLbl.text=UserDefaults.standard.string(forKey: "name")
            
        }
        else{
            self.view.makeToast("Failed to Load.")
        }
        
       
        if let data=UserDefaults.standard.object(forKey: "savedImage")
        {
            profilePicture.image=UIImage(data: data as! Data)
        }
     
        setupNavForDefaultMenu()
        
        // Add left bar button item
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "burger"), style: .plain, target: self, action: #selector(toggleSideMenu))
        navigationItem.leftBarButtonItem = leftBarItem
        
        
        
        
        title = "Profile"
        
    }
   
    
    @objc func selectImage()
    {
        let picker=UIImagePickerController()
        picker.delegate=self
        present(picker, animated: true)
        
        
    }
   
    
    
//    @IBAction func qrCodeButton(_ sender: Any) {
//        let vc=self.storyboard!.instantiateViewController(withIdentifier: "qrCodeViewController")
//        present(vc, animated: true, completion: nil)
//        print("yes")
//
//    }
    
    @objc func qrbutton() {
        print("qr button")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "qrCodeViewController") as! qrCodeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
       print("executed")
        
    }

        
        
        
   
    
 
    
    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension profileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    // Code to store image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image=info[UIImagePickerController.InfoKey.originalImage]{
            profilePicture.image=(image as! UIImage)
            let imageData:NSData=profilePicture.image!.pngData()! as NSData
            UserDefaults.standard.set(imageData,forKey: "savedImage")
          
            
//            let saveImage = (image as! UIImage).pngData() as NSData?
//            defaults.set(saveImage, forKey: "test")
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    

}
