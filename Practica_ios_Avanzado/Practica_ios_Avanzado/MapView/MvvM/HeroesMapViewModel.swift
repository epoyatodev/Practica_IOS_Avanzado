//
//  HeroesMapViewModel.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation

class HeroesMapViewModel: NSObject {
    
    override init() {
        
    }
    var updateUI: ((_ hero: HeroModel, _ location: [LocationHeroe])-> Void)?
    
    func getData(_ hero: HeroModel){
        
        let apiClient = ApiClient(token: readDataKeychain(getEmail()))
       
        apiClient.getLocationHeroes(with: hero.id) { [weak self] location, error in
            self?.updateUI?(hero, location)
            
        } 
      
    }
}
