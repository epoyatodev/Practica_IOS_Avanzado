//
//  LoginViewController.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import UIKit
import CoreData

protocol LoginDelegate {
    func dismiss()
}


class LoginViewController: UIViewController {
    
    var mainView: LoginView { self.view as! LoginView }
    
    var loginButton: UIButton?
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    var errorMessage: UILabel?
    
    var viewModel: LoginViewModel?
    
    var user: [User] = []
    
    override func loadView() {
        let loginView = LoginView()
        
        loginButton = loginView.getLoginButtonView()
        emailTextField = loginView.getEmailView()
        passwordTextField = loginView.getPasswordView()
        errorMessage = loginView.getErrorView()
        
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel()
        
        loginButton?.addTarget(self, action: #selector(didLoginTapped), for: .touchUpInside)
        #if DEBUG

        emailTextField?.text = "enripoor@hotmail.es"
        passwordTextField?.text = "poyatodev"

        #endif
        
        //user = getEmployees()
        
    }
    
    @objc
    func didLoginTapped(sender: UIButton){
        guard let email = emailTextField?.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        guard let password = passwordTextField?.text, !password.isEmpty else {
            print("pasword is empty")
            return
        }
        
        viewModel?.updateUI = { [weak self] token, error in
            if readDataKeychain(email) == ""{
                saveDataKeychain(token, email)
                saveEmail(email)
                
                // Prepare the info to notification
                let loginResponse = ["miData": ["token": token]]
                // Send a notification
                NotificationCenter.default.post(name: NSNotification.Name("notification.login.result"),
                                                object: nil,
                                                userInfo: loginResponse)
                
                return
            }
            
            if !error.isEmpty {
                DispatchQueue.main.async {
                    self?.errorMessage?.text = error
                }
                deleteTokenKeychain(email)
            }
        }
        
        // Call view model to login with the apiClient
        viewModel?.login(email: email, password: password)
    }
    

    }
    
    private func loginAndSaveTokenInKeychain(){
        
        
    

    

}
