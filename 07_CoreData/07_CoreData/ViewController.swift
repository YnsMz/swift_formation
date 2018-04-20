//
//  ViewController.swift
//  07_CoreData
//
//  Created by Etudiant on 19/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtAdresse: UITextField!
    @IBOutlet weak var txtNom: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    @IBOutlet weak var etqDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNom.text = ""
        txtAdresse.text = ""
        txtTelephone.text = ""
        etqDisplay.text = ""
        
    }

    
    @IBAction func btnSaveContactTouched(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else{
                print("Echec récupération appDelegate")
            return
        }
        //print(appDelegate)
        
        let contexte = appDelegate.persistentContainer.viewContext
        
        //let descriptionPersonne = NSEntityDescription.entity(forEntityName: "Personne", in: contexte)!
        
        //let personne = Personne(entity: descriptionPersonne, insertInto: contexte)
        
        let personne = NSEntityDescription.insertNewObject(forEntityName: "Employe", into: contexte) as! Employe
        
        
        personne.nom = txtNom.text
        personne.adresse = txtAdresse.text
        personne.telephone = txtTelephone.text
        
        do {
            try contexte.save()
            txtNom.text = ""
            txtAdresse.text = ""
            txtTelephone.text = ""
            etqDisplay.text = "Contact Sauvegardé"
        }
        catch let erreur {
            etqDisplay.text = erreur.localizedDescription
        }
        
    }
    
    
    @IBAction func btnChercherTouched(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                print("Echec récupération appDelegate")
                return
        }
        
        let contexte = appDelegate.persistentContainer.viewContext
        
        let descriptionPersonne = NSEntityDescription.entity(forEntityName: "Employe", in: contexte)
        
        let requete :NSFetchRequest <Employe> = Employe.fetchRequest()
        
        requete.entity = descriptionPersonne
        
        let predicate = NSPredicate(format: "nom=[cd]%@ && adresse=%@", txtNom.text!, txtAdresse.text!)
        
        requete.predicate = predicate
        
        do {
            var resultats = try contexte.fetch(requete)
            if(resultats.count > 0)
            {
                let article = resultats[0]
                
                txtNom.text = article.nom
                txtAdresse.text = article.adresse
                txtTelephone.text = article.telephone
                
                etqDisplay.text = "Nombre d'articles trouvés: \(resultats.count)"
            }
            else
            {
                etqDisplay.text = "Aucun artcile n'a été trouvé"
            }
        }
        catch let erreur {
            print(erreur.localizedDescription)
        }
        
    }
    
    
    @IBAction func btnSupprimerTouched(_ sender: Any) {
        let fm = FileManager.default
        
        var urlDatabase = fm.urls(for: .libraryDirectory, in: .userDomainMask).first!
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                print("Echec récupération appDelegate")
                return
        }
        
        let nom = appDelegate.persistentContainer.name
        
        urlDatabase.appendPathComponent("Application Support/" + nom + ".sqlite")
        
        print(urlDatabase)
        
        do {
            try appDelegate.persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: urlDatabase, ofType: NSSQLiteStoreType, options: nil)
            
                etqDisplay.text = "La base de données a été supprimée"
            
        }
        catch let erreur {
            print(erreur.localizedDescription)
        }
        
        do {
            try appDelegate.persistentContainer.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: urlDatabase, options: nil)
        }
        catch let erreur {
            print(erreur.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

