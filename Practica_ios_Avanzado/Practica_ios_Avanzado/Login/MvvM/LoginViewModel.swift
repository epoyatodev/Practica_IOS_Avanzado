//
//  LoginViewModel.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation


class LoginViewModel: NSObject {
    func login() -> ApiClient {
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUifQ.eyJpZGVudGlmeSI6IjEyMzlFNERBLTM3N0MtNERGMS1CRTEwLTY5QjVFODZDNzA4RSIsImVtYWlsIjoicG1nQHRlc3QuY29tIiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.JTg2J1GgSu0mvz8DZ5DM7LYXpoG7f7q-2hBIaU13RrY"
        
        return ApiClient(token: token)
    }
    
    var updateUI: ((_ token: String, _ error: String) -> Void)?
    
    func login(email: String, password: String) {
        
        ApiClient(token: "").login(user: email, password: password) { [weak self] token, error in
            
            
            if let token = token {
                self?.updateUI?(token, "")
                return
            }

            if let error = error {
                self?.updateUI?("", error.localizedDescription)
                return
            }

        }
    }
}

