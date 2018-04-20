//
//  Gateau.swift
//  04_ListePersonnalisee
//
//  Created by Etudiant on 17/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import Foundation

class Gateau
{
    var nom:String
    var nomImage:String
    var description:String
    
    init(nom:String, nomImage:String, description:String)
    {
        self.nom = nom
        self.description = description
        self.nomImage = nomImage
    }
}
