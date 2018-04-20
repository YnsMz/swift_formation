//
//  ViewController.swift
//  06_PList
//
//  Created by Etudiant on 18/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var etqNom: UILabel!
    @IBOutlet weak var etqPrenom: UILabel!
    @IBOutlet weak var etqDateNaissance: UILabel!
    @IBOutlet weak var textSalaire: UITextField!
    @IBOutlet weak var textNbEnfant: UITextField!
    @IBOutlet weak var textTelephone: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        print(bundle.description)
        
        let nomFichier = bundle.path(forResource: "DonneesPersonnelles", ofType: "plist")!
        print(nomFichier)
        
        let dico = NSMutableDictionary.init(contentsOfFile: nomFichier)!
        print(dico)
        
        
        etqPrenom.text = dico.object(forKey: "Prenom") as? String
        
        etqNom.text = dico.object(forKey: "Nom") as? String
        
        let date = dico.object(forKey: "Date_Naissance") as! Date
        etqDateNaissance.text = date.description
        
        let nbEnfant = dico.object(forKey: "Nombre_enfant") as! Int
        textNbEnfant.text = nbEnfant.description
        
        let salaire = dico.object(forKey: "Salaire") as! NSNumber
        textSalaire.text = salaire.description
        
        textTelephone.text = ""
        
        let fm = FileManager.default
        
//        fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        //v1
        do{
            let urlRepDocuments = try fm.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            print(urlRepDocuments)
        }
        catch let erreur {
            print(erreur.localizedDescription)
        }
        
        //v2
        let urlRepDocuments = try! fm.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
        
        let url = urlRepDocuments.appendingPathComponent("Perso.plist")
        print(url)
        
        if let dico2 = NSMutableDictionary.init(contentsOfFile: url.path){
            
            if let nbEnfant = dico2.object(forKey: "Nombre_Enfant") as? Int{
                textNbEnfant.text = "\(nbEnfant)"
            }
            if let salaire = dico2.object(forKey: "Salaire") as? NSNumber{
                textSalaire.text = "\(salaire)"
            }
            if let telephone = dico2.object(forKey: "Telephone"){
                textTelephone.text = "\(telephone)"
            }
            
        }
        
    }
    
    @IBAction func btnSaveTouched(_ sender: Any) {
        
        let telephone = textTelephone.text!
        
        var erreurTrouvee: Bool! = false
        
        var salaire: Float = -1
        
        if let valeur = Float(textSalaire.text!){
            salaire = valeur
        }
        else{
            erreurTrouvee = true
        }
        
        var nbEnfant: Int = -1
        
        if let valeur = Int(textNbEnfant.text!){
            nbEnfant = valeur
        }
        else{
            erreurTrouvee = true
        }
        
        if(erreurTrouvee){
            let alerte = UIAlertController(title: "Erreur saisie", message: "Vei=uillez saisir des données correctes", preferredStyle: UIAlertControllerStyle.alert)
            
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            present(alerte, animated: true, completion: nil)
            
            return
        }
        
        let dico = NSMutableDictionary()

        dico["Telephone"] = telephone
        dico["Nombre_Enfant"] = nbEnfant
        dico["Salaire"] = salaire
        
        let fm = FileManager.default
        let urlRepDocuments = try! fm.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        
        let url = urlRepDocuments.appendingPathComponent("Perso.plist")
        
        dico.write(to: url, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

