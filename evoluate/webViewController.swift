//
//  webViewController.swift
//  evoluate
//
//  Created by Aakarsh S on 24/03/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import WebKit
import Toast_Swift
class webViewController: UIViewController {

    var url = URL(string: "https://www.instagram.com/honestindianguy")
    //This value you are getting from menuTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeToast("Please wait..")
       
            webView.load(URLRequest(url: url!))
        

        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        setupNavForDefaultMenu()
        
        
        
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "burger"), style: .plain, target: self, action: #selector(toggleSideMenu))
        navigationItem.leftBarButtonItem = leftBarItem
        
        
        
           let rightBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem=rightBarItem
        
    }
    
    
    private func setupNavForDefaultMenu() {
        // Revert navigation bar translucent style to default
        navigationBarNonTranslecentStyle()
        
        // Update side menu after reverted navigation bar style
        sideMenuManager?.instance()?.menu?.isNavbarHiddenOrTransparent = false
        navigationItem.hidesBackButton = false
    }
    
    
    @objc func toggleSideMenu() {
        sideMenuManager?.toggleSideMenuView()
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
    
    @objc func goBack(){
        
       
        self.navigationController?.popViewController(animated: true)
        
    }
}
