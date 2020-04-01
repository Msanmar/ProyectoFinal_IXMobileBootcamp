//
//  PostViewCell.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 31/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {

   
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(texto: String, usuario: String){
        label.text = "\(texto)"
        username.text = "\(usuario)"
        //print(label.intrinsicContentSize)
        //label.preferredMaxLayoutWidth = 40
        label.numberOfLines = 0
       // label.minimumScaleFactor = 1
       // label.sizeToFit()
       //label.adjustsFontSizeToFitWidth = true
       // label.lineBreakMode = .byTruncatingTail
      
        
    }

     static func estimatedRowHeight() -> CGFloat{
   return 140
     
    }
    
}
