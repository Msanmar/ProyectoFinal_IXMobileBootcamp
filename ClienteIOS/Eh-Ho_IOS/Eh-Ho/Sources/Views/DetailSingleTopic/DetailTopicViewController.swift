//
//  DetailTopicViewController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class DetailTopicViewController: UIViewController {

    let viewModel: DetailTopicViewModel
    
    @IBOutlet weak var textLabelID: UILabel!
    @IBOutlet weak var textLabelCreatedAt: UILabel!
    @IBOutlet weak var textLabelUsername: UILabel!
  
    @IBOutlet weak var textTitleLabel: UILabel!
    
    @IBOutlet weak var textLabelEditable: UITextField!
    
    init(viewModel: DetailTopicViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @IBAction func editableButton(_ sender: Any) {
        
        var titleTopic: UITextField?
      
        if (textLabelEditable.text != "Topic editable") {
            print("Topic no editable")
             self.showAlertError(title: "Este topic no es editable", vc: self)
            
        }else{ //TOPIC EDITABLE
            
        let alerta = UIAlertController(title: "Para editar el título del topic...",
                                       message: "... introduce nuevo título",
                                       preferredStyle: UIAlertController.Style.alert)
        
        alerta.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "nuevo título del topic"
            textField.borderStyle = .line
            textField.textColor = .red
            titleTopic = textField
        })
        
        let sendAction = UIAlertAction(title: "Enviar",
                                       style: UIAlertAction.Style.default) { _ in
                                        alerta.dismiss(animated: true, completion: nil)
                                        
                                
                        // Comprobación de que el título que se introduce es válido
            if (titleTopic?.text != nil) && (titleTopic?.text != "") {
                self.viewModel.editTopic(newTitle: titleTopic!.text!)
                self.viewModel.updateTopics()
                                            
                    } else {
                print("Error/Alerta: El nuevo título del topic no puede estar vacío")
                    self.showAlertError(title: "El nuevo título del topic no puede estar vacío", vc: self)
                
                }
                                        
        }
        
        alerta.addAction(sendAction)
        self.present(alerta, animated: true, completion: nil)
        } //ELSE topic editable
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textTitleLabel.text = ""
        
        //textTextTitle.textColor = .red
        
        viewModel.viewDidLoad()
    }
}


extension DetailTopicViewController {
    
    func showAlertError(title: String, vc: DetailTopicViewController) {
        
        let alert = UIAlertController(title: "Error...", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in alert.dismiss(animated: true, completion: nil)}
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
}



// VIEWMODEL COMMUNICATION
protocol DetailTopicViewControllerProtocol: class {
    func showDetailTopic(id: Int, title: String, username: String, createdat: String, editable: String, visits: Int)
    func showError(with message: String)
    
}

extension DetailTopicViewController: DetailTopicViewControllerProtocol {
    func showDetailTopic(id: Int, title: String, username: String, createdat: String, editable: String, visits: Int) {
        //print("Show Detail Topic Title:      \(title)")
//        textTextTitle.text = "Título del topic: \(title)"
        textTitleLabel.text = "\(title)"
        textLabelUsername.text = "\(username)"
        textLabelID.text = " \(visits)"
        
        
        if editable == "Editable" {
        textLabelEditable.text = "Topic editable"
            
        }else{
            textLabelEditable.text = "Topic no editable"
        }
        
    
    }
    
    func showError(with message: String) {
        print("Error en DetailTopicViewController")
    }
    
    
}
