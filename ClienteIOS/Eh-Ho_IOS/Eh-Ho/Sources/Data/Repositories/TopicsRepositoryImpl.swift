//
//  LatestRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsRepositoryImpl: TopicsRepository {
 
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }

    
    // Obtener un Single Topic identificado por un id
    func getSingleTopicById(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ())  {
        print("===>>> Lanzamos REQUEST a servidor: getSingleTopicById...........")
        let request = SingleTopicRequest(id: id)
        session.send(tipoReq: "",request: request) { result in
            completion(result)
        }
      
    }
    
    
    // Obtener los latest Topics
    func getLatestTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor: getLatestTopics...........")
        
        let request = LatestTopicsRequest()
        session.send(tipoReq: "latest",request: request) { result in
            completion(result)
        }
    }
    
    // Obtener la lista completa de categorías
    func getListCategories(completion: @escaping (Result<ListCategoriesResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor: getListCategories...........")
        let request = ListCategoriesRequest()
        session.send(tipoReq: "",request: request) { result in
            completion(result)
        
        }
    }
    
    //Obtener la lista de topics de una categoría
    func getListTopicsCategory(catId: Int, completion: @escaping (Result<ListTopicsCategoryResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor:getListTopicsCategory...........")
        let request = ListTopicsCategoryRequest(catId: catId)
    
        session.send(tipoReq: "",request: request) { result in
            completion(result)
        }
        
        
    }
    
    
    //Obtener una respuesta sobre un filtro "term"
    func getFilteredResponse(text: String, completion: @escaping(Result<FilteredResponse, Error>) -> ()) {
        
       // print("getFilteredResponse............\(text)")
        
        let request = FilteredResponseRequest(text: text)
        
    
        session.send(tipoReq: "filtered", request: request) { result in
         //print("RESPONSE______________________")
            completion(result)
        }
        
    }
    
    //Obtener una página adicional de los latest topics
       func getMoreLatestTopics(page: String, completion: @escaping(Result<LatestTopicsResponse, Error>) -> ()) {
           
          // print("getFilteredResponse............\(text)")
           
        let request = PaginationRequest(page: page)
           
       
           session.send(tipoReq: "pagination", request: request) { result in
            //print("RESPONSE______________________")
               completion(result)
           }
           
       }
       
    
    
    
    // Crear un nuevo topic
    func createNewTopic(title: String, raw: String, createdAt: String, category: Int, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor: createNewTopic...........")
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt, category: category)
        session.send(tipoReq: "", request: request) { result in
            completion(result)
        }
    }
   
    // Obtener los posts de un topic identificado por un id
    func getListPostsTopic(topicId: Int, completion: @escaping (Result<ListPostsTopicResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor: getListPostsTopic...........")
        let request = ListPostsTopicRequest(topicId: topicId)
        session.send(tipoReq: "", request: request) { result in
            completion(result)
        }
    }
    
    // Crear un nuevo post en un topic determinado
    func createNewPost(topicId: Int, raw: String, completion: @escaping (Result<AddNewPostResponse,Error>) ->()) {
        print("===>>> Lanzamos REQUEST a servidor: createNewPost...........")
        let request = CreatePostRequest(topicId: topicId, raw: raw)
        session.send(tipoReq: "",request: request) { result in
            completion(result)
        }
    }
    
    // Editar un topic
    func editTopic(title: String, category_id: Int, id: Int, completion: @escaping (Result<EditTopicResponse, Error>) -> ()) {
        print("===>>> Lanzamos REQUEST a servidor: editTopic...........")
        let request = EditTopicRequest(title: title, category_id: category_id, id: id)
        session.send(tipoReq: "",request: request) { result in
            completion(result)
        }
    }
    

    
    
}
