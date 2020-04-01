//
//  TopicsCategoryViewModel.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsCategoryViewModel {
    
    private let mDataManager = DataManager()
    private var mTopicsCategoryResponse: Array<Topic> = Array()
    private var mUserPreferences = UserDefaultsPreferences()
    //private let maxTime: Int = 15 // segundos máximos de validez de la info
    
    
    weak var view: TopicsCategoryViewControllerProtocol?
    let router: TopicsCategoryRouter
    let topicsRepository: TopicsRepository
    let catId: Int //Id de la categoría a mostrar
    
    init(catId: Int, router: TopicsCategoryRouter, topicsRepository: TopicsRepository){
        self.catId = catId
        self.router = router
        self.topicsRepository = topicsRepository
        
    }
    
    func viewDidLoad() {
        fetchTopicsCategory()
        
    }
    

    
    
    func didTapInTopic(topicId: Int) { // Se reaprovecha el modulo
        
        router.navigateToPostsTopic(topicId: topicId)
    }
    
    private func fetchTopicsCategory() {
        
        let networkState = DetectNetwork()
        if networkState.connected() {
            print("HAY CONEXIÓN a internet, calculamos tiempo desde última petición a servidor")
        
    if (self.mUserPreferences.checkTimeIntervalTopics() > maxTime.maxTimeTopics) {
           print("____Tiempo en segundos: \(mUserPreferences.checkTimeIntervalTopics()) ___obtenemos datos del SERVIDOR")
        
        topicsRepository.getListTopicsCategory(catId: catId) { result in
            
            // Guardamos Date de la petición
            let date = Date()
            self.mUserPreferences.saveDateTopics(date: date)
            
            switch result {
            case .success(let value):
               
                //Limpiamos en la BD lista de topics de esa category
                self.mDataManager.deleteAllTopicsCategory(catId: self.catId)
                
                //Salvamos los topics en la BD
                print("Tenemos \(value.topicList.topics.count) topics en la categoría \(self.catId)")
                for i in 0...(value.topicList.topics.count-1) {
                    if (self.mDataManager.saveTopicsCategory(catId: self.catId, response: value.topicList.topics[i])==true){
                        //OK
                    }
                }
                
                //Mostramos los topics de esa categoría
                self.view?.showListOfTopics(topics: value.topicList.topics)

            case .failure:
                print("Error get List Topics Category")
            } // switch
            
        } // get List
        
    } else { // Tiempo menor al permitido, se obtienen datos de la BD
         print("___Tiempo en segundos: \(mUserPreferences.checkTimeIntervalTopics()), obtenemos datos de la BD")
        
        //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
        if !(self.mDataManager.loadResponseTopics(catId: catId).isEmpty)  {
            self.view?.showListOfTopics(topics: self.mDataManager.loadResponseTopics(catId: catId))
            } else {
            print("Error al intentar recuperar los topics de la BD => la tabla está vacía")
            }
        
        }//else tiempo máx
        
        }//if conexión a internet
        else {//No hay conexión a internet
              print("NO HAY CONEXIÓN a internet, tenemos que cargar datos desde la BD")
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            if !(self.mDataManager.loadResponseTopics(catId: catId).isEmpty)  {
                self.view?.showListOfTopics(topics: self.mDataManager.loadResponseTopics(catId: catId))
            } else {
                print("Error al intentar recuperar los topics de la BD => la tabla está vacía")
            }
            
            
        }//else no hay conexión a internet
    }
    
}
