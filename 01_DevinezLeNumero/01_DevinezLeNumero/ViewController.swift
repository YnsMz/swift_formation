//
//  ViewController.swift
//  01_DevinezLeNumero
//
//  Created by Etudiant on 16/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtSaisie: UITextField!
    @IBOutlet weak var etqScore: UILabel!
    
    @IBOutlet weak var pixelInfo: UIView!
    
    @IBOutlet weak var etqDisplay: UILabel!
    var score :Int = 0
    var valeur_a_deviner: UInt32=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialiser l'UI
        etqScore.text = "0"
        txtSaisie.text = ""
        
        valeur_a_deviner = tirerUneValeurAleatoire()
    }
    
    //créer un tableau contenant les couleurs du pixel espion
    var tbCouleurs = [UIColor.white, UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    
    @IBAction func btnTesterTouched(_ sender: UIButton)
    {
        //Recuperer la saisie
        let saisie = txtSaisie.text
        
        let chaine_a_deviner = "\(valeur_a_deviner)"
        
        if saisie == chaine_a_deviner
        {
           etqDisplay.text = "Réponse Correcte"
           etqDisplay.textColor = UIColor.green
           score += 1
        }
        else{
            etqDisplay.text = "Réponse erronée"
            etqDisplay.textColor = UIColor.red
            score -= 1
        }
        
        //Teste que le score n'est pas negatif
        score = score < 0 ? 0: score
        
        //afficher le score
        etqScore.text = "\(score)"
            
        txtSaisie.text = ""
        
        
        
        valeur_a_deviner = tirerUneValeurAleatoire()
        print("Valeur à deviner: \(valeur_a_deviner)")
        
    }
    
    func tirerUneValeurAleatoire() -> UInt32
    {
       let v = arc4random_uniform(5)
        
        pixelInfo.backgroundColor = tbCouleurs[Int(v)]
        
        return v
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

