//
//  ViewController.swift
//  evoluate
//
//  Created by Aakarsh S on 02/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet weak var name: DesignableUITextField!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let custGreen : UIColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
        name.layer.borderColor = custGreen.cgColor
         name.layer.borderWidth = 2.0
        
      
        signUp.layer.cornerRadius=signUp.frame.size.height/2
       
       
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var signUp: UIButton!
    @IBAction func continuetoLogin(_ sender: Any) {
        if let name=name.text
        { if name.isEmpty==false{
            UserDefaults.standard.set(name,forKey:"name")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
        else{
            self.view.makeToast("Enter Name to proceed.")
            }
            
        }
        
        
        
        
        
      
        
    }
    


    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess"{
            //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //            let nextViewController = storyBoard.instantiateViewCo
            
            
            
            //
            
        }
        
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

