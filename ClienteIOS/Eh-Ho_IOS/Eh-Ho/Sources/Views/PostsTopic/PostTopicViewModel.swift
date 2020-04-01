//
//  PostTopicViewModel.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostsTopicViewModel {
    
    private let mDataManager = DataManager()
   // private var mPostsTopicResponse: Array<Post> = Array()
    private var mUserPreferences = UserDefaultsPreferences()
   // private let maxTime: Int = 15 // segundos máximos de validez de la info
    
    weak var view: PostsTopicViewControllerProtocol?
    let router: PostsTopicRouter
    let topicsRepository: TopicsRepository
    let topicId: Int //Id del topic a mostrar
    
    init(topicId: Int, router: PostsTopicRouter, topicsRepository: TopicsRepository){
        self.topicId = topicId
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
        fetchPostsTopic()
    }
    
    
    private func fetchPostsTopic() {
      
        let networkState = DetectNetwork()
        if networkState.connected() {
            print("HAY CONEXIÓN a internet, calculamos tiempo desde última petición a servidor")
            
        
        if (self.mUserPreferences.checkTimeIntervalPosts() > maxTime.maxTimePosts) {
             print("____Tiempo en segundos: \(mUserPreferences.checkTimeIntervalPosts()) ___obtenemos datos del SERVIDOR")
            
            topicsRepository.getListPostsTopic(topicId: topicId) { result in
                
                // Guardamos Date de la petición
                let date = Date()
                self.mUserPreferences.saveDatePosts(date: date)
                
                switch result {
                case .success(let value):
                    
                    self.mDataManager.deleteAllPostsTopic(topicId: self.topicId)
                 
                    for i in 0...(value.postStream.posts.count-1) {
                        print(self.mDataManager.savePostsTopic(topicId: self.topicId, response: value.postStream.posts[i]))
                    }
                    
                    
                    self.view?.showListOfPosts(posts: (value.postStream.posts))
                    
                case .failure:
                    print("Error")
                } // result
                
            } // get list
        
        } else {
              print("___Tiempo en segundos: \(mUserPreferences.checkTimeIntervalPosts()), obtenemos datos de la BD")
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            if !(self.mDataManager.loadResponsePosts(topicId: topicId).isEmpty)  {
                
                self.view?.showListOfPosts(posts: self.mDataManager.loadResponsePosts(topicId: self.topicId))
            } else {
                print("Error al intentar recuperar los posts de la BD => la tabla está vacía")
            }
            
        }//else tiempo máximo
        }//if conexión a internet
        else { //No hay conexión a internet
            print("NO HAY CONEXIÓN a internet, tenemos que cargar datos desde la BD")
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            
            
            if !(self.mDataManager.loadResponsePosts(topicId: topicId).isEmpty)  {
                
                self.view?.showListOfPosts(posts: self.mDataManager.loadResponsePosts(topicId: self.topicId))
            } else {
                print("Error al intentar recuperar los posts de la BD => la tabla está vacía ")
            }
            
        }//else no hay conexión a internet
        
    }
    
    
    func createNewPost(topicId: Int, raw: String) {
        print("Create new post en topicId \(topicId)")
        topicsRepository.createNewPost(topicId: topicId, raw: raw) { result in
            switch result {
            case .success( _):
             
                    //Actualizamos los posts del topic
                self.fetchPostsTopic()
                
            case .failure( _):
               
                print("Error")
            }
        }
        
    }
    
}
