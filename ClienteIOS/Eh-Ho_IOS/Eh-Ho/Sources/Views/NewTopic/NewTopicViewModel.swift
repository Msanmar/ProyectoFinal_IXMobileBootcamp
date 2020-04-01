//
//  NewTopicViewModel.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//



import Foundation

class NewTopicViewModel {
    
    
    private let mDataManager = DataManager()
    private var mTopicsCategoryResponse: Array<Topic> = Array()
    private var mUserPreferences = UserDefaultsPreferences()
    private let maxTime: Int = 15 // segundos máximos de validez de la info
    
    weak var viewTopics: TopicsCategoryViewControllerProtocol?
    
    weak var view: NewTopicViewControllerProtocol?
    let router: NewTopicRouter
    let newtopicRepository: TopicsRepository
    
  
    
    
    init(router: NewTopicRouter,
         newtopicRepository: TopicsRepository) {
        self.router = router
        self.newtopicRepository = newtopicRepository
      
    }
    
    func viewDidLoad(title: String, raw: String, createdAt: String, category: Int) {
     
        createNewTopic(title: title, raw: raw, createdAt: createdAt, category: category)
    }
    
 
    
    private func createNewTopic(title: String, raw: String, createdAt: String, category: Int) {
        newtopicRepository.createNewTopic(title: title, raw: raw, createdAt: createdAt, category: category) { result in
            switch result {
            case .success( _):
                
                self.saveNewTopic(catId: category)
                
            case .failure:
               
               print("Failure create New Topic")
            /*default:
                print("Error create new Topic")*/
            }
        }
    }
    
    
    // Salvar en BD el new topic recién creado mediante la opción del TabBar
     private func saveNewTopic(catId: Int) {
         
         self.newtopicRepository.getListTopicsCategory(catId: catId) { result in
             
             switch result {
             case .success(let value):
                 
                 self.mDataManager.deleteAllTopicsCategory(catId: catId)
                 
                 for i in 0...(value.topicList.topics.count-1) {
                     self.mDataManager.saveTopicsCategory(catId: catId, response: value.topicList.topics[i])
                 }
                 
                 //Mostramos los topics de esa categoría
                 self.viewTopics?.showListOfTopics(topics: value.topicList.topics)
                 
             case .failure:
                 print("Error")
             } // switch
             
         } // get List
         
     }
}
