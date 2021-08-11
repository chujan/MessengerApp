//
//  WelcomeViewController.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 05/08/2021.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
       
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        
    }

   

}
