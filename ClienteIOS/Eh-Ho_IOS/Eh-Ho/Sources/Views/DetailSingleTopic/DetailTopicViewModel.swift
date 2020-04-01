//
//  DetailViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation


class DetailTopicViewModel {
    
    
    private let mDataManager = DataManager()
    //private var mTopicsCategoryResponse: Array<Topic> = Array()
    private var mUserPreferences = UserDefaultsPreferences()
    //private let maxTime: Int = 15 // segundos máximos de validez de la info
    
    weak var view: DetailTopicViewControllerProtocol?
    let topicId: Int
    let catId: Int
    let router: DetailTopicRouter
    let topicsRepository: TopicsRepository
    
    
    init(topicId: Int,
         catId: Int,
         router: DetailTopicRouter,
         topicsRepository: TopicsRepository) {
        self.topicId = topicId
        self.catId = catId
        self.router = router
        self.topicsRepository = topicsRepository
        
        
    }
    
    func viewDidLoad() {
        fetchSingleTopic()
    }
    
    
    
    
    func editTopic(newTitle: String){
        
        
        topicsRepository.editTopic(title: newTitle, category_id: catId, id: topicId) { result in
            
            switch result {
            case .success( _):
                
                print("Editado topic con ID \(self.topicId) \(self.catId), guardamos en BD")
                
                //Guardamos el topic editado en la Base de Datos
                if  (self.mDataManager.updateSingleTopic(topicId: self.topicId, catId: self.catId, newTitle: newTitle) == true){
                    //OK
                }
                
            case .failure( _):
                //Enviaremos a la vista el error
                print("")
                break
            }
        }
        
    }
    
    func updateTopics(){
        
        router.navigateToUpdateTopics()
    }
    
    
    private func fetchSingleTopic() {
        
        let networkState = DetectNetwork()
        if networkState.connected() {
            print("HAY CONEXIÓN a internet, calculamos tiempo desde última petición a servidor")
            
            if (self.mUserPreferences.checkTimeIntervalSingleTopic() > maxTime.maxTimeSingleTopic) {
                print("____Tiempo en segundos: \(mUserPreferences.checkTimeIntervalSingleTopic()) ___obtenemos datos del SERVIDOR")
                
                topicsRepository.getSingleTopicById(id: topicId) { result in
                    
                    // Guardamos Date de la petición
                    let date = Date()
                    self.mUserPreferences.saveDateSingleTopic(date: date)
                    
                    switch result {
                    case .success(let value):
                        
                        let edit: String
                        if value.details.canEdit == true { edit = "Editable" } else { edit = "No editable" }
                        
                        // TODO - Guardamos SingleTopic en BD (value devuelve SingleTopicResponse
                        // Habría que crear una tabla de tipo SingleTopicResponse (no vale topic)
                        
                        //print(type(of: self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId)))
                        
                        //self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId)
                        // Pintamos en la vista los valores devueltos de la request
                        self.view?.showDetailTopic(id: value.id, title: value.title, username: value.details.createdBy.username, createdat: value.createdAt, editable: edit, visits: value.views)
                        
                    case .failure( _):
                        print("Error request")
                        break
                    }//result
                } //get Single Topic by ID
                
            }//if tmax
            else {//Tiempo menor al permitido, cargamos de la BD
                print("___Tiempo en segundos: \(mUserPreferences.checkTimeIntervalSingleTopic()), obtenemos datos de la BD")
                
                //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
                if self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId) != nil {
                    print("Ese topic está en la BD ya, se puee mostrar")
                    
                    //Tomamos valores de la BD (de la tabla topic, por eso no tenemos el createdAt y el username (SingleTopicResponse)
                    let id = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).id
                    let title = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).title
                    let username = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).lastPosterUsername ?? ""
                    let visits = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).views
                    
                     self.view?.showDetailTopic(id: id, title: title , username: username, createdat: "", editable: "", visits: visits)
                } else {
                    print("Ese topic no está en la BD almacenado")
                }
                
            } //else tiempo
        } //if conexión a internet
        else { //No hay conexión a internet
            print("NO HAY CONEXIÓN a internet, tenemos que cargar datos desde la BD")
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            if (self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId)) != nil {
                print("Mostramos los detalles del topic almacenados en la BD")
                
                //Tomamos valores de la BD (de la tabla topic, por eso no tenemos el createdAt y el username (SingleTopicResponse)
                let id = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).id
                let title = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).title
                let username = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).lastPosterUsername ?? ""
                let visits = self.mDataManager.loadSingleTopic(catId: self.catId, topicId: self.topicId).views
                
                self.view?.showDetailTopic(id: id, title: title , username: username, createdat: "", editable: "", visits: visits)
            } else {
                print("Ese topic no está en la BD almacenado")
            }
            
            
            
            
        }
    }
        
}
