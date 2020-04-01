//
//  APIClient.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

final class SessionAPI {
    
    private let mDataManager = DataManager()
    private var mListCategoriesResponse: Array<ListCategoriesResponse> = Array()
    
    //https://applecoding.com/tutoriales/combine-urlsession
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    //...... SEND
    func send<T: APIRequest>(tipoReq: String, request: T, completion: @escaping(Result<T.Response, Error>) -> ()) {
        let request = request.requestWithBaseUrl(tipoReq: tipoReq)
      print(request)
        
        let task = session.dataTask(with: request) { data, response, error in
           
           // print(data)
           // print(response)
            //print(error)
            
            do {
            
                if let data = data {
                    
                   // print(String(data: data as! Data, encoding: String.Encoding.utf8))
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                   //print("Obtenido model")
                   //print(model)
                    
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                   
                }
            } catch let jsonErr {
               
                print("Error en respuesta dentro de función SEND -> más que probable error de PARSEO", jsonErr)
                }
        }
        task.resume()
    }
    
   
}
