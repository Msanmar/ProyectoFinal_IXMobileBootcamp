//
//  CategoriesViewModel.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewModel {
    
    private let mDataManager = DataManager()
    private var mListCategoriesResponse: Array<ListCategoriesResponse> = Array()
    private var mUserPreferences = UserDefaultsPreferences()

    weak var view: CategoriesViewControllerProtocol?
    let router: CategoriesRouter
    let categoriesRepository: TopicsRepository
   
    
    init(router: CategoriesRouter,
         categoriesRepository: TopicsRepository) {
        self.router = router
        self.categoriesRepository = categoriesRepository
    }
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    // MOSTRAR LISTA DE CATEGORIAS: pantalla inicial
    func fetchCategories() {
        
        let networkState = DetectNetwork()
        if networkState.connected() {
            print("HAY CONEXIÓN a internet, calculamos tiempo desde última petición a servidor")
        
        if (self.mUserPreferences.checkTimeIntervalCategories() > maxTime.maxTimeCategories) {
              print("____Tiempo en segundos: \(mUserPreferences.checkTimeIntervalCategories()) ___obtenemos datos del SERVIDOR")
            
        categoriesRepository.getListCategories { [weak self] result in
            
            // Guardamos Date de la petición
            let date = Date()
            self?.mUserPreferences.saveDateCategories(date: date)
            
            switch result {
            case .success(let value):
                
                self?.mDataManager.deleteAllDataCategories()
                
                // Guardamos la lista de categorías recibidas en la base de datos
                for i in 0...(value.categoryList.categories.count-1) {
                    if (self?.mDataManager.saveCategories(response: value.categoryList.categories[i]) == true){
                        //OK
                    }
                }
                
                //Mostramos las categories recibidas del servidor
                self?.view?.showCategories(categories: value.categoryList.categories)
               
            case .failure:
                self?.view?.showError(with: "Error al obtener las categories, ¿servidor?")
            } // switch
        } //get list Categories
            
            
        } else { //No lanzamos petición, si no que la cogemos de la BD
             print("___Tiempo en segundos: \(mUserPreferences.checkTimeIntervalCategories()), obtenemos datos de la BD")
            
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            if !(self.mDataManager.loadResponseCategories().isEmpty)  {
                self.view?.showCategories(categories: self.mDataManager.loadResponseCategories())
            } else {
                print("Error al intentar recuperar las categories de la BD => la tabla está vacía")
            }
        }// else tiempo
        }//if conexión a internet
        else { //No hay conexión a internet
            
            print("NO HAY CONEXIÓN a internet, tenemos que cargar datos desde la BD")
            //Cargamos los datos de la BD, en vez de lanzar la petición al servidor
            
            if !(self.mDataManager.loadResponseCategories().isEmpty)  {
                self.view?.showCategories(categories: self.mDataManager.loadResponseCategories())
            } else {
                print("Error al intentar recuperar las categories de la BD => la tabla está vacía")
            }
            
            
            
        }
    }
    
    // MOSTRAR LISTA DE TOPCs de una CATEGORía (al pulsar en una)
    func didTapInCategory(id: Int) {
        router.navigateToCategoryDetail(id: id)
        
        
    }
    
   
    
}
