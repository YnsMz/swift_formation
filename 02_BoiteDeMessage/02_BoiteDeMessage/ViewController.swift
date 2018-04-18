//
//  ViewController.swift
//  02_BoiteDeMessage
//
//  Created by Etudiant on 16/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var etqDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnDialogue2Touched(_ sender: Any) {
        
        etqDisplay.text = ""
        
        let alerte = UIAlertController(title: "Boite de dialogue 2",
                                       message: "Ceci est la boite de dialogue 2",
                                       preferredStyle: UIAlertControllerStyle.alert)
        
        let handlerOK{}
        
        let btnOK = UIAlertAction(title: "OK",
        style: .default,
        handler: handlerOK)
        
        alerte.addAction(btnOK)
        
        //Bouton Annuler
        let handlerAnnuler = {
            (action:UIAlertAction) -> Void in
            self.etqDisplay.text = "La boite de dialogue 2 a été fermée avec le bouton Annuler"
            print("La boite de dialogue 2 a été fermée avec le bouton")
        }
        
        let btnAnnuler = UIAlertAction(title: "Annuler",
                                       style: UIAlertStyle.cancel,
                                       handler: handlerAnnuler)
        
        alerte.addAction(btnAnnuler)
        
        //Bouton Supprimer
        let handlerSupprimer = {
            (action:UIAlertAction) -> Void in
            let alerteCompteRendu = UIAlertController
            (title: "Compte rendu",
             message: "Laboite de dialogue2 a été fermée avec le bouton Supprimer",
             preferredStyle: UIAlertControllerStyle.alert)
            
            alerteCompteRendu.addAction(action)
            
            self.present(alerteCompteRendu, animated:true, completion:nil)
        }
        
        let btnSupprimer = UIAlertAction(title: "Supprimer",
                                         style:UIAlertStyle.destructive,
                                         handler: handlerSupprimer)
        
        alerte.addAction(btnSupprimer)
        present(alerte, animated:true, completion: nil)
        
    }
    
    


    @IBAction func btnDialogue3Touched(_ sender: Any) {
        
        etqDisplay.text = ""
        
        let alerte = UIAlertController(title: "Boite de dialogue 3",
                                       message: "Ceci est la boite de dialogue 3",
                                       preferredStyle: UIAlertControllerStyle.alert)
        
        //champs de saisie personnalisé
        alerte.addTextField(configurationHandler:{ (boiteSaisie: UITextField) in
                                boiteSaisie.placeholder = "Année de naissance"
                                boiteSaisie.textColor = UIColor.magenta
                                boiteSaisie.keyboardAppearance = .dark
                                boiteSaisie.keyboardType = .default
                                boiteSaisie.clearButtonMode = .whileEditing
        })
        
        let btnSoumettre = UIAlertAction(title: "Soumettre", style: UIAlertActionStyle.default,
                                         handler: {
                                            (action) -> Void in
                                            let champSaisie = alerte.textFields![0]
                                            print(champSaisie.text!)
                                            self.etqDisplay.text = champSaisie.text!
        })
        
        alerte.addAction(btnSoumettre)
        
        let btnAnnuler = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.default,                             handler:nil)
        
        alerte.addAction(btnAnnuler)
        
        present(alerte, animated:true, completion:nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
