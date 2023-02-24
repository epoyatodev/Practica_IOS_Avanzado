//
//  HeroModel.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//
import Foundation

struct HeroModel: Decodable {
    let photo: String
    let id: String
    let name: String
    let description: String
    var latitud: Double?
    var longitud: Double?
    
}
