//
//  CategoriesViewController.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: CategoriesViewModel
    var categories: [Category] = [] // Revisar
    var topics: [Topic] = [] // Revisar
   
    private var mUserPreferences = UserDefaultsPreferences()
    
    lazy var refreshControl:UIRefreshControl = {
        
        let refresControl = UIRefreshControl()
       //refresControl.attributedTitle = NSAttributedString(string: "Looking for new topics...")
        refresControl.addTarget(self, action: #selector(CategoriesViewController.refreshCategories(_ :)), for: .valueChanged)
        refresControl.tintColor = UIColor.blue
        return refresControl
        
    }()
    
   private let mDataManager = DataManager()
    private var mListCategoriesResponse: Array<ListCategoriesResponse> = Array()
    
    init(categoriesViewModel: CategoriesViewModel) {
        self.viewModel = categoriesViewModel
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
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        
        
        //Llamamos al viewModel
        viewModel.viewDidLoad()
    }
    
    
    @objc private func refreshCategories(_ refresControl: UIRefreshControl) {
        //print("...Refresh Categories")
       //viewModel.viewDidLoad()
        viewModel.fetchCategories()
        self.tableView.reloadData()
        
       refresControl.endRefreshing()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name //Revisar - cambiar
        // cell.textLabel?.text = "category dummy \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let id = categories[indexPath.row].id
        print(categories[indexPath.row].name)
        print(categories[indexPath.row].categoryDescription)
        viewModel.didTapInCategory(id: categories[indexPath.row].id)
    }
    
}



// MARK: - ViewModel Communication
protocol CategoriesViewControllerProtocol: class {
    func showCategories(categories: [Category])
    func showError(with message: String)
   // func showTopicsCategory(topics: [Topic])
}

extension CategoriesViewController: CategoriesViewControllerProtocol {
    func showCategories(categories: [Category]) {
        self.categories = categories
        self.tableView.reloadData()
    }
    
   
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
}
