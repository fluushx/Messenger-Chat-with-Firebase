//
//  ViewController.swift
//  Firebase Chat App
//
//  Created by Felipe Ignacio Zapata Riffo on 06-09-21.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {
         
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         validateAuth()
    }
    
    private func validateAuth(){
         
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

