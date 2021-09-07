//
//  LoginViewController.swift
//  Firebase Chat App
//
//  Created by Felipe Ignacio Zapata Riffo on 06-09-21.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        
         
        return logoImageView
    }()
    
    //MARK: mailTextField
    private let mailTextField : UITextField = {
       let mailTextField = UITextField()
        mailTextField.textColor = .black
        mailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.autocapitalizationType = .none
        mailTextField.placeholder =  "Type Your Mail"
        mailTextField.backgroundColor = .white
        mailTextField.layer.cornerRadius = 10
        mailTextField.layer.masksToBounds = true
        mailTextField.font = .systemFont(ofSize: 15)
        mailTextField.leftViewMode = .always
        mailTextField.layer.shadowColor = UIColor.lightGray.cgColor
        mailTextField.layer.shadowOffset = CGSize(width:3, height:3)
        mailTextField.layer.shadowOpacity = 3
        mailTextField.layer.shadowRadius = 3
        mailTextField.layer.borderWidth = 0.5
        mailTextField.layer.borderColor = UIColor.black.cgColor
        mailTextField.autocorrectionType = .no
        return mailTextField
    }()
    //MARK: passwordTextField
    private let passwordTextField : UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "Type Your Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.shadowColor = UIColor.lightGray.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width:3, height:3)
        passwordTextField.layer.shadowOpacity = 3
        passwordTextField.layer.shadowRadius = 3
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.textColor = .black
        passwordTextField.returnKeyType = .done
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
     
    //MARK: loginButton
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .link
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowOffset = CGSize(width:3, height:3)
        loginButton.layer.shadowOpacity = 3
        loginButton.layer.shadowRadius = 3
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return loginButton
    }()
    
    //MARK: containerView
    private let containerView : UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemFill
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = CGSize(width:3, height:3)
        containerView.layer.shadowOpacity = 3
        containerView.layer.shadowRadius = 3
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.backgroundColor = .systemGray6
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In "
        setUpView()
        setUpRightBarButton()
        setUpConstraints()
        mailTextField.delegate = self
        passwordTextField.delegate = self
        logoImageView.isUserInteractionEnabled = true
        containerView.isUserInteractionEnabled =  true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        logoImageView.addGestureRecognizer(gesture)
    }
     
    @objc func didTapRegisterButton(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLoginButton(){
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let mail = mailTextField.text, let password = passwordTextField.text,
              !mail.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        //Log in firebase
        FirebaseAuth.Auth.auth().signIn(withEmail: mail, password: password, completion: {
            authResult, error in
            guard let result = authResult, error == nil else {
                let alert = UIAlertController(title: "Woops",
                                              message: "Incorrect Password o Email",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                                              style: .cancel,
                                              handler: nil))
                self.present(alert, animated: true)
                return
            }
            let user = result.user
            print(" Log in User: \(user)")
        })

    }
    @objc private func didTapChangeProfilePic(){
        print("tap")
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter information to log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
        
    }
    
    func setUpRightBarButton (){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegisterButton))
    }
    func setUpView(){
        view.addSubview(logoImageView)
        view.addSubview(containerView)
        containerView.addSubview(mailTextField)
        containerView.addSubview(passwordTextField)
        view.addSubview(loginButton)
         
    }
    func setUpConstraints(){
         
        //MARK:- imageLoginCenter
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 135).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //MARK:- containerView
        containerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
         
        //MARK:- mailTextField
        mailTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        mailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        mailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
         
        //MARK:- passwordTextField
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK:- loginButton
        loginButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailTextField{
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
