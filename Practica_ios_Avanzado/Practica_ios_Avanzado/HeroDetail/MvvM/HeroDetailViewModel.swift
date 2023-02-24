//
//  HeroDetailViewModel.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation

class HeroDetailViewModel: NSObject {
    override init() {
        
    }
    
    var updateUI: ((_ hero: HeroModel?, _ error: String) -> Void)?
    
    func getDataForASpecificHearo(name: String) {
        let apiClient = ApiClient(token: readDataKeychain(getEmail()))

        apiClient.getHeroByName(name: name) { [weak self] hero, error  in
            
            guard error == nil else {
                self?.updateUI?(nil, "Se produjo un error al obtener los detalles del héroe")
                return
            }

            guard let hero = hero else {
                self?.updateUI?(nil, "Se produjo un error al obtener los detalles del héroe")
                return
            }
            
            self?.updateUI?(hero, "")
        }
    }
}
