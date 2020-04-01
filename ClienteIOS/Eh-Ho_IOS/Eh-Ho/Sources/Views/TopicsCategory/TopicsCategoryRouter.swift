//
//  TopicsCategoryRouter.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsCategoryRouter {

    weak var viewController: UIViewController?
    
    static func configureModule(id: Int) -> UIViewController {
        
        let router = TopicsCategoryRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = TopicsCategoryViewModel(catId: id, router: router, topicsRepository: topicsRepository)
        let viewController = TopicsCategoryViewController(topicsCategoryViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
        
    }
    
    func navigateToTopicDetail(topicId: Int, catId: Int) {
        let viewControllerToPushTopics = DetailTopicRouter.configureModule(topicId: topicId, catId: catId)
        viewController?.navigationController?.pushViewController(viewControllerToPushTopics, animated: true)
    }
    
    // Camino para obtener propiedad de editabilidad de un topic
    /*func getEditableState(topicId: Int) -> Bool {
        let dtr = DetailTopicRouter()
        if (dtr.showEditableState(id: topicId) != true) {
            //print("FALSO")
            return false
        }else{
            //print("TRUE")
            return true
        }
        
    
    }*/
    
    
    func navigateToPostsTopic(topicId: Int) {
        let viewControllerToPushPosts = PostsTopicRouter.configureModule(topicId: topicId)
       viewController?.navigationController?.pushViewController(viewControllerToPushPosts, animated: true)
    }
    
}
