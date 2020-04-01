//
//  CreateNewTopicRouter.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class NewTopicRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {

        let router =  NewTopicRouter()
        let sessionApi = SessionAPI()
        let newTopicRepository = TopicsRepositoryImpl(session: sessionApi)

        let viewModel = NewTopicViewModel(router: router, newtopicRepository:  newTopicRepository)
        let viewController = NewTopicViewController(viewModel: viewModel)
      
        viewModel.view = viewController
         router.viewController = viewController
        
        return viewController
        
    }
    
    
    
}
