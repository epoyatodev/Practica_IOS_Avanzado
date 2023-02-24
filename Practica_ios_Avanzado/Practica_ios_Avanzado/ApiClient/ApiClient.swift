//
//  ApiClient.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation

enum NetworkError: Error {
  case malformedURL
  case noData
  case statusCode(code: Int?)
  case decodingFailed
  case unknown
}

final class ApiClient {
  
  private var token: String?
  
  convenience init(token: String) {
    self.init()
    self.token = token
  }
    
  
  func login(user: String, password: String, completion: @escaping (String?, Error?) -> Void) {
    guard let url = URL(string: "\(Constants.api_base_url)/auth/login") else {
      completion(nil, NetworkError.malformedURL)
      return
    }
    
    let loginString = String(format: "%@:%@", user, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard error == nil else {
        completion(nil, NetworkError.unknown)
        return
      }
      
      guard let data = data else {
        completion(nil, NetworkError.noData)
        return
      }
      
      guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        completion(nil, NetworkError.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
        return
      }
      
      guard let response = String(data: data, encoding: .utf8) else {
        completion(nil, NetworkError.decodingFailed)
        return
      }
      
      self.token = response
      completion(response, nil)
    }
    
    task.resume()
  }
  
    func getHeroes(completion: @escaping ([HeroModel], Error?) -> Void) {
      guard let url = URL(string: "\(Constants.api_base_url)/heros/all"), let token = self.token else {
        completion([], NetworkError.malformedURL)
        return
      }
      
      var urlComponents = URLComponents()
      urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
      
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
      
      let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard error == nil else {
          completion([], NetworkError.unknown)
          return
        }
        
        guard let data = data else {
          completion([], NetworkError.noData)
          return
        }
        
        guard let response = try? JSONDecoder().decode([HeroModel].self, from: data) else {
          completion([], NetworkError.decodingFailed)
          return
        }
        completion(response, nil)
      }
      
      task.resume()
    }

    func getHeroByName(name: String, completion: @escaping (HeroModel?, Error?) -> Void) {
      guard let url = URL(string: "\(Constants.api_base_url)/heros/all"), let token = self.token else {
        completion(nil, NetworkError.malformedURL)
        return
      }

      var urlComponents = URLComponents()
      urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      urlRequest.httpBody = urlComponents.query?.data(using: .utf8)

      let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard error == nil else {
          completion(nil, NetworkError.unknown)
          return
        }

        guard let data = data else {
          completion(nil, NetworkError.noData)
          return
        }

        guard let response = try? JSONDecoder().decode([HeroModel].self, from: data) else {
          completion(nil, NetworkError.decodingFailed)
          return
        }
          completion(response.first, nil)
      }

      task.resume()
    }
    
    
    
    func getLocationHeroes(with id: String, completion: @escaping ([LocationHeroe], Error?) -> Void) {
      guard let url = URL(string: "\(Constants.api_base_url)/heros/locations"), let token = self.token else {
        completion([], NetworkError.malformedURL)
        return
      }
      
      var urlComponents = URLComponents()
      urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]
      
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
      
      let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard error == nil else {
          completion([], NetworkError.unknown)
          return
        }
        
        guard let data = data else {
          completion([], NetworkError.noData)
          return
        }
        
        guard let response = try? JSONDecoder().decode([LocationHeroe].self, from: data) else {
          completion([], NetworkError.decodingFailed)
          return
        }
        completion(response, nil)
      }
      
      task.resume()
    }


}
