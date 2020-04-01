//
//  PostsTopicRouter.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostsTopicRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule(topicId: Int) -> UIViewController {
        let router = PostsTopicRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = PostsTopicViewModel(topicId: topicId, router: router, topicsRepository:  topicsRepository)
        let viewController = PostsTopicViewController(topicId: topicId, postsTopicViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
        
    }
    
    
 
    
}
