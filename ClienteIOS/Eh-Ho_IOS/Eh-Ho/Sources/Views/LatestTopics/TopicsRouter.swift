//
//  TopicsRouter.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        let router = TopicsRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = TopicsViewModel(router: router, topicsRepository: topicsRepository)
        let viewController = TopicsViewController(topicsViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToTopicDetail(topicId: Int, catId: Int) {
        let viewControllerToPush = DetailTopicRouter.configureModule(topicId: topicId, catId: catId)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    func updateTopics(){
        let router = TopicsRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = TopicsViewModel(router: router, topicsRepository: topicsRepository)
        let viewController = TopicsViewController(topicsViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        viewModel.updateTopics()
    }
}
