//
//  Globals.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation
import CoreData

typealias HandlerHeroe = (_ heroe: Hero) -> Void

var contextUsers = AppDelegate.sharedAppDelegate.coreDataUsers.managedContext
var contextHeroes = AppDelegate.sharedAppDelegate.coreDataHeroes.managedContext
var currentUser: User?
var currentHeroe: Hero?
var updateHeroe: HandlerHeroe?


// MARK: CoreData

func saveHeroeCoreData(_ id: String, _ photo: String, _ name: String, _ heroeDescription: String, _ longitud: String, _ latitud: String) {
    // Guardo la info en CoreData
    
    
    let heroe = Hero(context: contextHeroes)
    
    heroe.id = id
    heroe.photo = photo
    heroe.name = name
    heroe.heroeDescription = heroeDescription
    heroe.latitud = latitud
    heroe.longitud = longitud
 
    
    do {
        try contextHeroes.save()
    } catch let error {
        debugPrint(error)
    }
    
}

func getHeroesCoreData() -> [Hero] {
    let heroeFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
    
    do {
        let result = try contextHeroes.fetch(heroeFetch)
        
        return result
        
    } catch let error as NSError {
        debugPrint("Error -> \(error)")
        return []
    }
}

func updateHeroesCoreData(_ longitud: String, _ latitud: String) {
   
    
    guard let currentHeroe  else { return }
    
    currentHeroe.longitud = longitud
    currentHeroe.latitud = latitud
    updateHeroe?(currentHeroe)
}

func deleteHeroesCoreData() {
    // Obtener los objetos de la entidad que deseas eliminar
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hero")
    let heroes = try! contextHeroes.fetch(fetchRequest) as! [NSManagedObject]
    
    // Iterar a través de los objetos y eliminarlos del contexto
    heroes.forEach({ heroe in
        contextHeroes.delete(heroe)
    })
    
    
    do {
        
        // Guardar los cambios en el contexto
        try contextHeroes.save()
        print("Heroes deleted susccessfully ( CoreData )")
    } catch let error as NSError {
        debugPrint("Error during deleting heroes of coreData -> \(error)")
    }
    
}




func getEmail() -> String {
    let userFetch: NSFetchRequest<User> = User.fetchRequest()
    
    do {
        let result = try contextUsers.fetch(userFetch)
        return result.first?.email ?? ""
        
    } catch let error as NSError {
        debugPrint("Error -> \(error)")
        return ""
    }
}

func saveEmail(_ email: String) {
    // Guardo la info en CoreData
    
    
    let user = User(context: contextUsers)
    
    user.email = email
    
    do {
        
        try contextUsers.save()
        
    } catch let error {
        debugPrint(error)
    }
    
}







// MARK: KeyChain

func saveDataKeychain(_ token: String, _ email: String) {
    // Definimos un usuario
    let userName = email
    let token = token.data(using: .utf8)!
    
    // Preparamos los atributos necesarios
    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: userName,
        kSecValueData as String: token
    ]
    // Guardamos el usuario
    
    if SecItemAdd(attributes as CFDictionary, nil) == noErr {
        //debugPrint("Información del usuario guardada con éxito")
    } else {
        //debugPrint("Se produjo un error al guardar la información del usuario")
    }
    
    
}


func readDataKeychain(_ email: String) -> String {
    var tokenUser = ""
    // Establecer el usuaio que queremos encontrar
    let userName = email
    // Preparamos la consulta
    let query: [String: Any] = [
        
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: userName,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnAttributes as String: true,
        kSecReturnData as String: true
        
        
    ]
    
    var item: CFTypeRef?
    
    if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
        // extraemos la informacion
        if let item = item as? [String: Any],
           //let username = item[kSecAttrAccount as String] as? String,
           let tokenData = item[kSecValueData as String] as? Data,
           let token = String(data: tokenData, encoding: .utf8) {
            
            //debugPrint("Usuario recuperado -> \(username) - \(token)")
            
            
            tokenUser = token
            
        }
    }
    return tokenUser
    
    
}


func deleteTokenKeychain(_ email: String) {
    let userName = email
    let query : [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: userName
    ]
    
    if ( SecItemDelete(query as CFDictionary)) == noErr {
        debugPrint("Token deleted successfully (KeyChain)")
    } else {
        debugPrint("Error during deleting token of KeyChein")
        
    }
    
}
