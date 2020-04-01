//
//  PostTopicViewController.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostsTopicViewController: UIViewController {
    
    //Definir IBOutlet tableView
    
  
  
   // @IBOutlet weak var tableView: UITableView!
    private var tableView: UITableView!
    
    let viewModel: PostsTopicViewModel
    var posts: [Post] = []
    let topicId: Int
    
    init(topicId: Int, postsTopicViewModel: PostsTopicViewModel) {
        self.viewModel = postsTopicViewModel
        self.topicId = topicId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        navigationController?.navigationBar.prefersLargeTitles = true
       
        makeTable()
        registerNib()
        setUpTableView()
    
        viewModel.viewDidLoad()
       
    }
    
    private func makeTable() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
            ])
    }
    
    
    private func registerNib() {
        let nib = UINib(nibName: "PostViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostViewCell")

    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
       
      
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = PostViewCell.estimatedRowHeight()
       
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
}

extension PostsTopicViewController {
    
private func deleteTopic() {
    _ = UIBarButtonItem(
            title: "Delete topic",
            style: .plain,
            target: self,
            action: #selector(borrarTopic)
        )
        
        // Lo añado a la navigation bar
 
       // navigationItem.leftBarButtonItems = [newDeleteTopicButton]
    }
    
    @objc private func borrarTopic(topicId: Int) {
        print("Pulsado botón borrar topic")
        
        
    }
    
 private func setupButton() {
        // Creo mi botón
        let newPostButton = UIBarButtonItem(
            title: "Create New Post",
            style: .plain,
            target: self,
            action: #selector(addNewPost)
        )
    newPostButton.tintColor = .orange
        
        
        // Lo añado a la navigation bar
            navigationItem.rightBarButtonItems = [newPostButton]
    }

    

    
    @objc private func addNewPost() {
    
          var titlePost: UITextField?
        //Bloque fechas
        

        
        let alerta = UIAlertController(title: "Vas a postear en este topic...",
                                       message: "... introduce el tútlo de tu post...",
                                       preferredStyle: UIAlertController.Style.alert)
        
        alerta.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "y el texto de tu post"
            textField.borderStyle = .line
            
            //textField.isSecureTextEntry = true
            textField.textColor = .red
           titlePost = textField
        })
        
        let sendAction = UIAlertAction(title: "Enviar",
                                    style: UIAlertAction.Style.default) { _ in
                                        alerta.dismiss(animated: true, completion: nil)
                                        
                                
                                        
                                        if (titlePost?.text != nil) && (titlePost?.text != "") {
                                            print("Se va a crear un nuevo post en el topic con ID", self.topicId)
                                            self.viewModel.createNewPost(topicId: self.topicId, raw: titlePost!.text!)
                                            
                                        } else {
                                            print("El título del nuevo post no puede estar vacío")
                                            self.showAlertError(title: "El título del post no puede estar vacío", vc: self)
                                            
                                            
                                        }
                                       
                                        
        }
        
        alerta.addAction(sendAction)
        
        
        self.present(alerta, animated: true, completion: nil)
        
       
        
    }
    
}

extension PostsTopicViewController {
    
    func showAlertError(title: String, vc: PostsTopicViewController) {
        
        let alert = UIAlertController(title: "Error...", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in alert.dismiss(animated: true, completion: nil)}
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
}

extension PostsTopicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as! PostViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as! PostViewCell
        
        //cell.textLabel?.text = "\(posts[indexPath.row].username) \( "=>" ) \(posts[indexPath.row].cooked)"

  
    
        let username = posts[indexPath.row].username
        

      var cooked = posts[indexPath.row].cooked
       
   
      let index = cooked.lastIndex(of: "<") ?? cooked.startIndex
      let parte = cooked[..<index]
      let strArray = parte.components(separatedBy: ">")
        
        cell.configure(texto: strArray[1], usuario: username)
    
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Swift 4.2 onwards
        return UITableView.automaticDimension
    }*/
    
    
/*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }*/
    
}

/*extension PostsTopicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = posts[indexPath.row].id
        //print("DidSelectRow at en PostsVC: pulsado el post id:\(id)")
      
    }
}*/

// MARK: - ViewModel Communication
protocol PostsTopicViewControllerProtocol: class {
    func showListOfPosts(posts: [Post])
    func showError(with message: String)
}

extension PostsTopicViewController: PostsTopicViewControllerProtocol {
    func showListOfPosts(posts: [Post]) {
        self.posts = posts
        //self.title = "Posts en topic id: \(topicId)"
        self.title = "Posts"
        self.tableView.reloadData()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
}
