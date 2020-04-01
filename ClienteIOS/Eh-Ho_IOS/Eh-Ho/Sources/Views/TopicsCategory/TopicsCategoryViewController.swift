//
//  TopicsCategoryViewController.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsCategoryViewController: UIViewController {
    
    //Definir IBOutlet tableView
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: TopicsCategoryViewModel
    var topics: [Topic] = []

    lazy var refreshControl:UIRefreshControl = {
        
        let refresControl = UIRefreshControl()
        refresControl.attributedTitle = NSAttributedString(string: "Looking for new topics...")
        refresControl.addTarget(self, action: #selector(TopicsCategoryViewController.refreshTopics(_ :)), for: .valueChanged)
        refresControl.tintColor = UIColor.blue
        return refresControl
        
    }()
    
    
    
    
    init(topicsCategoryViewModel: TopicsCategoryViewModel) {
        self.viewModel = topicsCategoryViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
            fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        let cell = UINib(nibName: "TopicViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: UITableViewCell.identifier)
        

       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    
        viewModel.viewDidLoad()
    }

    @objc private func refreshTopics(_ refresControl: UIRefreshControl) {
        print("..........Refresh Topics")
        
        viewModel.viewDidLoad()
        
        //self.tableView.reloadData()
        
        refresControl.endRefreshing()
        
    }
    
    
    func button(){
        print("button VC")
    }

}

extension TopicsCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
    
        cell.textLabel?.text = topics[indexPath.row].title
        cell.detailTextLabel?.text = "Visitas: \(topics[indexPath.row].views)"*/
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath) as? TopicViewCell else {
            return UITableViewCell()
        }
        
        let title = topics[indexPath.row].title
        let visits = topics[indexPath.row].views
        let postsCount = topics[indexPath.row].postsCount
        let date = topics[indexPath.row].createdAt
        
        print("................ Datos de celda a pintar")
        print(title)
        print(visits)
        print(postsCount)
        let fecha = String(date.prefix(10))
        print(fecha)
        print(".........................................")
       
        // Camino para obtener propiedad de editabilidad de un topic
        //let editable = viewModel.isTopicEditable(topicId: topics[indexPath.row].id)

        let editable = true

        cell.configure(title: title, visits: visits, editable: editable, postsCount: postsCount, date: fecha)
        
        return cell
    }
    
    
}

extension TopicsCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = topics[indexPath.row].id
       
        //print("Seleccionado topic \(id) \(topics[indexPath.row].title)")
        viewModel.didTapInTopic(topicId: id)
        
       
    }
}

// MARK: - ViewModel Communication
protocol TopicsCategoryViewControllerProtocol: class {
    func showListOfTopics(topics: [Topic])
    func showError(with message: String)
}

extension TopicsCategoryViewController: TopicsCategoryViewControllerProtocol {
    func showListOfTopics(topics: [Topic]) {
        self.topics = topics

        //self.title = "Cat: \(topics[0].categoryID) \("total topics:") \(topics.count)"
        self.title = "Topics"
        self.tableView.reloadData()
        
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
    
    
}
