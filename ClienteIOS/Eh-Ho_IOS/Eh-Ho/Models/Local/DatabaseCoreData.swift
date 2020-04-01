//
//  DatabaseCoreData.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 18/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

class DatabaseCoreData {
    
    // Categories
    private let entity_name_category = "Categories"
    private let entity_key_cat_name = "name"
    private let entity_key_cat_topicCount = "topicCount"
    private let entity_key_cat_id = "id"
    
    //Topics
    private let entity_name_topic = "Topics"
    private let entity_key_topic_id = "id"
    private let entity_key_topic_title = "title"
    private let entity_key_topic_postsCount = "postsCount"
    private let entity_key_topic_views = "views"
    private let entity_key_topic_categoryID = "categoryID"
    
    //Posts
    private let entity_name_post = "Posts"
    private let entity_key_post_id = "id"
    private let entity_key_post_name = "name"
    private let entity_key_post_username = "username"
    private let entity_key_post_cooked = "cooked"
    private let entity_key_post_topicID = "topicID"
    private let entity_key_post_canEdit = "canEdit"
    
   //Latest topics
    private let entity_name_latest_topics = "LatestTopics"
    private let entity_key_latest_topics_categoryID = "categoryID"
    private let entity_key_latest_topics_title = "title"
    private let entity_key_latest_topics_id = "id"
    private let entity_key_latest_topics_postsCount = "postsCount"
    private let entity_key_latest_topics_views = "views"
    
    
    // Obtener el contexto
    private func managedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // ... FETCH DATA REQUEST
    private func fetchDataRequest(context: NSManagedObjectContext, entity: String, predicate: String? = nil) -> [NSManagedObject]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if let predicateRequest = predicate, !predicateRequest.isEmpty {
            fetchRequest.predicate = NSPredicate(format: predicateRequest)
        }
        do{
            return try context.fetch(fetchRequest) as? [NSManagedObject]
            
        }catch{
            print("Error al crear y ejecutar fetchRequest para la entity: \(entity)")
            return nil
        }
        
    }
    
    
    // .... DELETE
    private func delete(data: [NSManagedObject], context: NSManagedObjectContext) -> Bool {
        do{
            data.forEach{
                context.delete($0)
            }
            try context.save()
            return true
            
        }catch {
            print("Error al eliminar todos los datos")
            return false
        }
    }
    
  
    
    
    // ... Categories saveCategories
    private func saveCategories(object: NSManagedObject, into context: NSManagedObjectContext, name: String, topicCount: Int, id: Int) -> Bool {
        do {
            object.setValue(name, forKey: entity_key_cat_name)
            object.setValue(topicCount, forKey: entity_key_cat_topicCount)
            object.setValue(id, forKey: entity_key_cat_id)
            try context.save()
           
            return true
            
        }catch{
            print("Error saveCategories")
            return false
        }
        
    }
    
    // ResponseCategories
    private func responseCategories(from responseCD: [NSManagedObject]) -> Array<Category> {
        
        return responseCD.compactMap { responseCD in
            guard let name = responseCD.value(forKey: entity_key_cat_name) as? String,
                let topicCount = responseCD.value(forKey: entity_key_cat_topicCount) as? Int,
                let id = responseCD.value(forKey: entity_key_cat_id) as? Int else {
                    print("Error compactMAP en responseCategories")
                    return nil
            }
            
           
            return Category(id: id, name: name, color: "", textColor: "", slug: "", topicCount: topicCount, postCount: 0, position: 0, categoryDescription: "", topicURL: "", backgroundURL: "", readRestricted: true, hasChildren: true, topicsDay: 0, topicsWeek: 0, topicsMonth: 0, topicsYear: 0, topicsAllTime: 0, descriptionExcerpt: "")
            
        }
        
    }
    
    
    // Response Topics
    private func responseTopics(from responseCD: [NSManagedObject]) -> Array<Topic> {
        
        
        return responseCD.compactMap { responseCD in
            guard let topicID = responseCD.value(forKey: entity_key_topic_id) as? Int,
                       let topicTitle = responseCD.value(forKey: entity_key_topic_title) as? String,
                        let postsCount = responseCD.value(forKey: entity_key_topic_postsCount) as? Int,
                         let views = responseCD.value(forKey: entity_key_topic_views) as? Int,
                            let categoryID = responseCD.value(forKey: entity_key_topic_categoryID) as? Int else {
                    print("Error compactMAP en responseTopics")
                    return nil
            }
            
            
            return Topic(id: topicID, title: topicTitle, fancyTitle: "", slug: "", postsCount: postsCount, replyCount: 0, highestPostNumber: 0, imageURL: "", createdAt: "", lastPostedAt: "", bumped: true, bumpedAt: "", unseen: true, pinned: true, unpinned: true, visible: true, closed: true, archived: true, notificationLevel: 0, bookmarked: true, liked: true, views: views, likeCount: 0, hasSummary: true, archetype: "", lastPosterUsername: "", categoryID: categoryID, pinnedGlobally: true, posters: Array())
            
        }
        
    }
    
    
    // Response Latest Topics
    private func responseLatestTopics(from responseCD: [NSManagedObject]) -> Array<Topic> {
        
        return responseCD.compactMap { responseCD in
            guard let topicID = responseCD.value(forKey: entity_key_latest_topics_id) as? Int,
                let topicTitle = responseCD.value(forKey: entity_key_latest_topics_title) as? String,
                let postsCount = responseCD.value(forKey: entity_key_latest_topics_postsCount) as? Int,
                let views = responseCD.value(forKey: entity_key_latest_topics_views) as? Int,
                let categoryID = responseCD.value(forKey: entity_key_latest_topics_categoryID) as? Int else {
                    print("Error compactMAP en responseTopics")
                    return nil
            }
            
            
            return Topic(id: topicID, title: topicTitle, fancyTitle: "", slug: "", postsCount: postsCount, replyCount: 0, highestPostNumber: 0, imageURL: "", createdAt: "", lastPostedAt: "", bumped: true, bumpedAt: "", unseen: true, pinned: true, unpinned: true, visible: true, closed: true, archived: true, notificationLevel: 0, bookmarked: true, liked: true, views: views, likeCount: 0, hasSummary: true, archetype: "", lastPosterUsername: "", categoryID: categoryID, pinnedGlobally: true, posters: Array())
            
        }
        
    }
    
    

    // Save topic
    private func saveTopic(object: NSManagedObject, into context: NSManagedObjectContext, catId: Int, id: Int, title: String, postsCount: Int? = nil, views: Int? = nil, categoryID: Int) -> Bool {
        
        // Objeto Topic => rellenamos y salvamos
        do {
            object.setValue(id, forKey: entity_key_topic_id)
            object.setValue(title, forKey: entity_key_topic_title)
            object.setValue(categoryID, forKey: entity_key_topic_categoryID)
            
            if  postsCount != nil {
                object.setValue(postsCount, forKey: entity_key_topic_postsCount)
            }
            
            if views != nil {
                object.setValue(views, forKey: entity_key_topic_views)
            }
            
            try context.save()
            return true
            
        }catch{
            print("Error al guardar la response saveTopic..........")
            return false
        }
        
        
        
        // Objeto Category, rellenamos con topic y salvamos
        
        do {
           //Revisar si es necesario
            let data = fetchDataRequest(context: context,
                                        entity: entity_name_category,
                                        predicate: "\(entity_key_cat_id) = \(catId)")
            data?.first!.setValue(NSSet(object: object), forKey: "topics")
            
            try context.save()
        } catch {
            print("Error al insertar topic dentro de category")
        }
        
        
    }// save Topic
    

    
    // Save Post
    private func savePost(object: NSManagedObject, into context: NSManagedObjectContext, topicId: Int, id: Int, name: String, username: String, cooked: String, canEdit: Bool?, topicID: Int) -> Bool {
        
        // Objeto Post => rellenamos y salvamos
        do {
            object.setValue(id, forKey: entity_key_post_id)
            object.setValue(name, forKey: entity_key_post_name)
            object.setValue(username, forKey: entity_key_post_username)
            object.setValue(cooked, forKey: entity_key_post_cooked)
            object.setValue(topicID, forKey: entity_key_post_topicID)
            object.setValue(canEdit, forKey: entity_key_post_canEdit)
            
            try context.save()
            return true
            
        }catch{
            print("Error al guardar la response savePost...........")
            return false
        }
        
        
        // Objeto Topic rellenamos con post y salvamos
        
        do {
            
            let dataTopic = fetchDataRequest(context: context,
                                        entity: entity_name_topic,
                                        predicate: "\(entity_key_post_topicID) = \(topicId)")
            dataTopic?.first!.setValue(NSSet(object: object), forKey: "posts")
            
            try context.save()
        } catch {
            print("Error al insertar post dentro de topic ")
        }
        
        
    }//savePost
    
    
    // Response Posts
    private func responsePosts(from responseCD: [NSManagedObject]) -> Array<Post> {
        
        return responseCD.compactMap { responseCD in
            guard let postID = responseCD.value(forKey: entity_key_post_id) as? Int,
                let postName = responseCD.value(forKey: entity_key_post_name) as? String,
                let postUsername = responseCD.value(forKey: entity_key_post_username) as? String,
                let cooked = responseCD.value(forKey: entity_key_post_cooked) as? String,
                let topicID = responseCD.value(forKey: entity_key_post_topicID) as? Int,
                let canEdit = responseCD.value(forKey: entity_key_post_canEdit) as? Bool? else {
                    print("Error compactMAP en responsePosts")
                    return nil
            }
            
            
            return Post(id: postID, name: postName, username: postUsername, avatarTemplate: "", createdAt: "", cooked: cooked, postNumber: 0, postType: 0, updatedAt: "", replyCount: 0, quoteCount: 0, incomingLinkCount: 0, reads: 0, score: 0, yours: true, topicID: topicID, topicSlug: "", displayUsername: "", version: 0, canEdit: canEdit, canDelete: true, canRecover: true, canWiki: true, read: true, bookmarked: true, actionsSummary: Array(), moderator: true, admin: true, staff: true, userID: 0, hidden: true, trustLevel: 0, userDeleted: true, canViewEditHistory: true, wiki: true)
            
            
        }
        
    } //Response Posts

    
}

extension DatabaseCoreData : DatabaseDelegate {
    
    
    func initDefaultData() {
        deleteAllDataCategories()
    }
    
    // ....... Funciones de Response tipo: LatestTopics
    func deleteAllLatestTopics() {
        guard let context = managedObjectContext() , let data = fetchDataRequest(context: context, entity: entity_name_latest_topics) else {
            return
        }
             _ = delete(data: data, context: context)
    }
    
    
    func saveLatestTopics(response: Topic) -> Bool {
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_name_latest_topics, in: context) else {
                return false
        }
        
        let topicObject = NSManagedObject(entity: entity, insertInto: context)
        
        
        //Llamamos a saveTopic con los parámetros de la response
         return saveTopic(object: topicObject, into: context, catId: response.categoryID, id: response.id, title: response.title, postsCount: response.postsCount, views: response.views, categoryID: response.categoryID)
        
    }
    
    
    func loadDataLatestTopics() -> Array<Topic> {
        
        //Obtenemos el contexto y la entity mediante fetchDataRequest
        guard let context = managedObjectContext(), let dataLatest = fetchDataRequest(context: context, entity: entity_name_latest_topics) else {
            print("No se puede obtener el contexto o la entity de latest topics")
            return Array()
        }
    
        
        
        return responseLatestTopics(from: dataLatest)
        
        
    }
    
    
    // ....... Funciones de Response tipo: ListCategories
    func deleteAllDataCategories() {
        guard let context = managedObjectContext() , let data = fetchDataRequest(context: context, entity: entity_name_category) else {
            return
        }
        
        _ = delete(data: data, context: context)
    }
    
    func saveCategories(response: Category) -> Bool {
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_name_category, in: context) else {
                return false
        }
        
        let responseObject = NSManagedObject(entity: entity, insertInto: context)
        
        
        return saveCategories(object: responseObject, into: context, name: response.name, topicCount: response.topicCount, id: response.id)
        
    }
    
    func loadDataCategories() -> Array<Category> {
        guard let context = managedObjectContext(), let data = fetchDataRequest(context: context, entity: entity_name_category) else {
            print("ERROR en data Categories")
            return Array()
        }
      
        return responseCategories(from: data)
    }
    
    //..... ListCategories.........
    
    
    //....... Funciones de Response tipo:  Topics Category
    func deleteAllTopicsCategory(catId: Int) {
        
        //Obtenemos contexto y data [NSManagedObject] tipo catId
        guard let context = managedObjectContext() , let _ = fetchDataRequest(context: context, entity: entity_name_category, predicate: "\(entity_key_cat_id) = \(catId)") else {
            return
        }
        
        //Necesitamos obtener el objeto topic de esa catID
        let dataTopic = fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_categoryID) = \(catId)")
        
        _ = delete(data: dataTopic!, context: context)
        
    }
   
    
    func saveTopicsCategory(catId: Int, response: Topic) -> Bool {
        
        //Obtenemos contexto & entity "Topics"
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_name_topic, in: context) else {
               
                return false
        }
        
        //Obtenemos un objeto tipo Topics
        let topicObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Llamamos a func Salvar con ese objeto, el contexto, y los datos a salvar
        return saveTopic(object: topicObject, into: context, catId: catId, id: response.id, title: response.title, postsCount: response.postsCount, views: response.views, categoryID: response.categoryID)
    
    }
    
    func loadDataTopics(catId: Int) -> Array<Topic> { // Cargar topics de una category
        
        //Obtenemos el contexto y la categoría en cuestión mediante fetchDataRequest
        guard let context = managedObjectContext(), let _ = fetchDataRequest(context: context, entity: entity_name_category, predicate: "\(entity_key_cat_id) = \(catId)") else {
            print("No se puede obtener el contexto o el objeto category filtrado por catId")
            return Array()
        }
      
        
        guard let dataTopic =  fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_categoryID) = \(catId)") else {
            print("No se puede obtener el objeto topic")
            return Array()
            
        }
        
     
       return responseTopics(from: dataTopic)
    }
    
    //Update Single Topic
    func updateSingleTopic(topicId: Int, catId: Int, newTitle: String) -> Bool {
        
        //Obtenemos el contexto y la categoría en cuestión mediante fetchDataRequest
        guard let context = managedObjectContext(), let _ = fetchDataRequest(context: context, entity: entity_name_category, predicate: "\(entity_key_cat_id) = \(catId)") else {
            print("No se puede obtener el contexto o el objeto category filtrado por catId")
            return false
        }
        
        guard let dataTopic =  fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_categoryID) = \(catId) AND \(entity_key_topic_id) = \(topicId) ") else {
            print("No se puede obtener el objeto topic")
            return true
            
        }
        
        return (saveTopic(object: dataTopic.first!, into: context, catId: catId, id: topicId, title: newTitle, categoryID: catId))
        
    }
    
    
    //Load Single Topic
    func loadSingleTopic(catId: Int, topicId: Int) -> Array<Topic> { // Cargar topic concreto de una catId concreta
        
        //Obtenemos el contexto y la categoría en cuestión mediante fetchDataRequest
        guard let context = managedObjectContext(), let _ = fetchDataRequest(context: context, entity: entity_name_category, predicate: "\(entity_key_cat_id) = \(catId)") else {
            print("No se puede obtener el contexto o el objeto category filtrado por catId")
            return Array()
        }
        
        guard let dataTopic =  fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_categoryID) = \(catId) AND \(entity_key_topic_id) = \(topicId) ") else {
            print("No se puede obtener el objeto topic")
            return Array()
            
        }
        
        return responseTopics(from: dataTopic)
    }
    
    
    
    //....... Funciones de Response tipo:  Posts Topic
    
     func savePostsTopic(topicId: Int, response: Post) -> Bool {
    
        //Obtenemos contexto & entity "Posts"
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_name_post, in: context) else {
                
                return false
        }
        
        //Obtenemos un objeto tipo Topics
        let postObject = NSManagedObject(entity: entity, insertInto: context)
        
        return savePost(object: postObject, into: context, topicId: topicId, id: response.id, name: response.name, username: response.username, cooked: response.cooked, canEdit: response.canEdit, topicID: response.topicID)
        
    }
    
    func deleteAllPostsTopic(topicId: Int) {
        
        //Obtenemos contexto y data [NSManagedObject] tipo topicId
        guard let context = managedObjectContext() , let _ = fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_id) = \(topicId)") else {
            print("Error al obtener contexto o la entity Topic")
            return
        }
        
        //Necesitamos obtener el objeto post de ese topicID
        let dataPost = fetchDataRequest(context: context, entity: entity_name_post, predicate: "\(entity_key_post_topicID) = \(topicId)")
        
        _ = delete(data: dataPost!, context: context)
        
    }//delete all posts
    

    
    func loadDataPosts(topicId: Int) -> Array<Post> {
        
        
        //Obtenemos el contexto y el topic en cuestión mediante fetchDataRequest
        guard let context = managedObjectContext(), let _ = fetchDataRequest(context: context, entity: entity_name_topic, predicate: "\(entity_key_topic_id) = \(topicId)") else {
            print("No se puede obtener el contexto o el objeto topic filtrado por topicID")
            return Array()
        }
       
        
        guard let dataPost =  fetchDataRequest(context: context, entity: entity_name_post, predicate: "\(entity_key_post_topicID) = \(topicId)") else {
            print("No se puede obtener el objeto post")
            return Array()
            
        }
        
        
        return responsePosts(from: dataPost)
        
        
    }
}
