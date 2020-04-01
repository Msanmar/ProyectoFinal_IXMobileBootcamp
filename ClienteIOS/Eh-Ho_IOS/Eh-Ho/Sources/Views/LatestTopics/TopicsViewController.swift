//
//  TopicsViewController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTopics : [FilteredResponse] = []
    
       private var mUserPreferences = UserDefaultsPreferences()
    
    let viewModel: TopicsViewModel
    var topics: [Topic] = []
    var maxPageSize : Int = 30
    var lastPage : Bool = false
    var page: Int = 0
  
  
    lazy var refreshControl:UIRefreshControl = {
        
        let refresControl = UIRefreshControl()
        refresControl.attributedTitle = NSAttributedString(string: "Looking for new topics...")
        refresControl.addTarget(self, action: #selector(TopicsViewController.refreshLatestTopics(_ :)), for: .valueChanged)
        refresControl.tintColor = UIColor.blue
        return refresControl
        
    }()
    
    init(topicsViewModel: TopicsViewModel) {
        self.viewModel = topicsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        //Search controller......
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.orange
        searchController.searchBar.placeholder = "Escribe una palabra para buscar Topics"
    
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
          //Search controller.....
        
       // mUserPreferences.saveDateLatestTopics(date: Date())
        
        viewModel.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
       
        //print(indexPath.row)
        if (indexPath.row == maxPageSize-1) && (lastPage==false){
            maxPageSize = maxPageSize + 30
            page = page + 1
             print("Will display...... último elemento. Cargamos más datos de la página", page)
       
            
            viewModel.getMoreLatestTopics(page: String(page))
            
          
        }
        
        
    }
    
    @objc func refreshLatestTopics(_ refresControl: UIRefreshControl) {
        print("Refresh Latest Topics")
        viewModel.viewDidLoad()
        self.tableView.reloadData()
        refresControl.endRefreshing()
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = topics[indexPath.row].title
        
        //cell.textLabel?.text = "Topic dummy \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topicId = topics[indexPath.row].id
        let catId = topics[indexPath.row].categoryID
        
        viewModel.didTapInTopic(topicId: topicId, catId: catId)
    }
    
}


extension TopicsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("UpdateSearchResults ............ en TopicsViewController")
        print(type(of: searchController.searchBar.text))
        
        if let term = searchController.searchBar.text  {
            if (!term.isEmpty) {
                print("Vamos a filtrar por la palabra \(term)")
                viewModel.retrieveFilteredTopics(text: term)
            }
             //self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
}
                
    



// MARK: - ViewModel Communication
protocol TopicsViewControllerProtocol: class {
    func showLatestTopics(topics: [Topic])
    func showMoreLatestTopics(topics: [Topic])
    func showFilteredTopics(filteredTopics: [FilteredTopic])
    func showError(with message: String)
    func updateTopics()
    
}

extension TopicsViewController: TopicsViewControllerProtocol {
    
    func showLatestTopics(topics: [Topic]) {
        print("ShowLatestTopics")
        self.tableView.separatorColor = UIColor.black
        
        self.topics = topics
        self.tableView.reloadData()
    }
    
    func showMoreLatestTopics(topics: [Topic]) {
           print("ShowMoreLatestTopics")
            
          var topicsBase: [Topic] = []
        
           self.tableView.separatorColor = UIColor.black
           topicsBase = self.topics + topics
           self.topics = topicsBase
            
            if topics.count < 30 {
                print("Ultima página de latest topics recuperada.............................................")
            lastPage = true
            }
        
           self.tableView.reloadData()
       }
    
    func showFilteredTopics(filteredTopics: [FilteredTopic]) {
        print("ShowLatestFilteredTopics")
        
        
        
        for i in 0...(filteredTopics.count-1){
            topics[i].id = filteredTopics[i].id
            topics[i].title = "===>>> FilteredTopic: \(filteredTopics[i].title)"
            //topics[i].slug = filteredTopics[i].slug
            topics[i].categoryID = filteredTopics[i].category_id
           // topics[i].postsCount = filteredTopics[i].posts_count
            
            
        }
        
        self.tableView.separatorColor = UIColor.orange
      //  self.tableView.style
        self.tableView.reloadData()
  
       }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
    
    func updateTopics() {
        showLatestTopics(topics: topics)
        self.tableView.reloadData()
    }
    
}



