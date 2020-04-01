//
//  APIRequest.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

let apiURL = "https://mdiscourse.keepcoding.io"

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest: Encodable {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}

// Default implementation of the protocol
extension APIRequest {
    
    var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
            fatalError("URL not valid")
        }
        return baseURL
    }
    
    func requestWithBaseUrl(tipoReq: String) -> URLRequest {
        // Primero, definimos cual va a ser la url con el recurso a llamar
        let url = baseURL.appendingPathComponent(path)
        // Aquí tendriamos: https://www.google.com/search
        
        // Segundo, si el objeto que lo implementa añade parametros, construimos la url con parametros
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        
     
        
        if !parameters.isEmpty {
            
           
            let key = parameters.keys.first! as String
            let value = parameters.values.first! as String
            
            print("parameters..........................")
            print(parameters.keys.count)
            print(parameters.keys.description)
            print(parameters.keys.first!)
          
           
            if (tipoReq=="filtered"){
            
            components.queryItems = [URLQueryItem(name: "term",value: key),URLQueryItem(name: "include_blurbs",value: value)]
                print(components)
            //components.queryItems = parameters.map { URLQueryItem(name: nombre, value: $1); URLQueryItem(name: nombre1, value: $1)}
            }
            
            if (tipoReq=="pagination"){
                components.queryItems = [URLQueryItem(name: "no_definitions",value: key),URLQueryItem(name: "page",value: value)]
                print(components)
                
            }
            
            
        }
        
    
        
        guard let finalUrl = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        // Aquí tendriamos: https://www.google.com/search?q=hola&oq=hola&aqs=chrome..69i57j69i60l4j69i61.378j0j7&sourceid=chrome&ie=UTF-8
        
        // Ahora a partir de una url, podemos construir nuestro objeto URLRequest, que lo necesitamos para crear last de URLSession
        var request = URLRequest(url: finalUrl)
        
        // Aquí definimos el verbo a usar: GET, POST...
        request.httpMethod = method.rawValue
        
        //Aquí añadimos el body si el objeto que lo implementa añade body
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
      
        
        // Aquí vamos definiendo las cabeceras de nuestra petición
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // API-KEY: 58a1eb95bb6764a783c0052f4387f78f42dd8772d8fa65e90d45f5a2fe14ffd3. Necesario para que el servidor nos reconozca
//        request.addValue("58a1eb95bb6764a783c0052f4387f78f42dd8772d8fa65e90d45f5a2fe14ffd3", forHTTPHeaderField: "Api-Key")
        //request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        // API-Username, necesario para que el servidor nos reconozca
        // Para la practica, cambiar el usuario nach por el que usasteis para registraros
        request.addValue("msanmar", forHTTPHeaderField: "Api-Username")
        print("REQUEST:::::::::::::::::::::")
       print(request)
        return request
    }
}
