//
//  MaCellule.swift
//  04_ListePersonnalisee
//
//  Created by Etudiant on 17/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class MaCellule: UITableViewCell {
    
    
    @IBOutlet weak var imgGateau: UIImageView!
    @IBOutlet weak var etqTitre: UILabel!
    @IBOutlet weak var etqDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
