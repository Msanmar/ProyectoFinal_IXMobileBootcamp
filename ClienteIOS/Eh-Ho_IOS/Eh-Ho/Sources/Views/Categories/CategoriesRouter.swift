//
//  CategoriesRouter.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CategoriesRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        let router = CategoriesRouter()
        let sessionApi = SessionAPI()
        let categoriesRepository = TopicsRepositoryImpl(session: sessionApi)
    
        
        let viewModel = CategoriesViewModel(router: router, categoriesRepository: categoriesRepository)
        let viewController = CategoriesViewController(categoriesViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToCategoryDetail(id: Int) {
        let viewControllerToPush = TopicsCategoryRouter.configureModule(id: id)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
}
