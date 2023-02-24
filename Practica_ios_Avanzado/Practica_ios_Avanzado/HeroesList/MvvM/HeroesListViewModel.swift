//
//  HeroesListViewModel.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation

class HeroesListViewModel: NSObject {
 
    override init() {
        
    }
    var updateUI: ((_ heroes: [HeroModel])-> Void)?
    
    func getData(){
        
        let apiClient = ApiClient(token: readDataKeychain(getEmail()))
        apiClient.getHeroes { [ weak self ] heroes, error in
            self?.updateUI?(heroes)
           
        }
      
    }
    
    
    
}
