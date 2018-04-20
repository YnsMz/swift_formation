//
//  ViewController.swift
//  08_CoreDataAvecAssociations
//
//  Created by Etudiant on 20/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var txtdisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func afficherTexte(_ texte: String){
        
        txtdisplay.text = txtdisplay.text + "\n" + texte
        
    }
    
    @IBAction func btnEffacerTouched(_ sender: Any) {
        txtdisplay.text = ""
    }
    
    func initialiser(){
        let fm = FileManager.default
        
        var urlDatabase = fm.urls(for: .libraryDirectory, in: .userDomainMask).first!
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                print("Echec récupération appDelegate")
                return
        }
        
        let nom = appDelegate.persistentContainer.name
        
        urlDatabase.appendPathComponent("Application Support/" + nom + ".sqlite")
        
        do {
            try appDelegate.persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: urlDatabase, ofType: NSSQLiteStoreType, options: nil)
            
            afficherTexte("La base de données a été supprimée")
            
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
        
        let personne1 = creerPersonne(nom: "Chirac", prenom: "Jacques", age: 80)
        
        let personne2 = creerPersonne(nom: "Chirac", prenom: "Bernadette", age: 70)
        let personne3 = creerPersonne(nom: "Hollande", prenom: "Francois", age: 60)
        let personne5 = creerPersonne(nom: "Sarkozy", prenom: "Nicolas", age: 50)
        let personne6 = creerPersonne(nom: "Macron", prenom: "Emmanuel", age: 40)
        
        let adresse1 = creerAdresse(numero: "25", rue: "Rivoli", ville: "Paris", pays: "France")
        let adresse2 = creerAdresse(numero: "178 Bis", rue: "Grande Rue", ville: "Villemomble", pays: "France")
        let adresse3 = creerAdresse(numero: "67", rue: "Georges Desthuilliers", ville: "Chelles", pays: "France")
        
        personne1.adresses = NSSet(object: adresse1)
        personne2.adresses = NSSet(objects: adresse1, adresse2, adresse3)
        personne2.adresses?.adding(adresse3)
        
        personne1.conjoint = personne2
        
        personne1.enfants = NSSet(objects: personne3, personne5)
        
        // ou
        // personne5.pere = personne1
        // personne3.pere = personne1
        
        let contexte = getContext()
        
        do {
            try contexte.save()
        } catch let erreur {
            print(erreur.localizedDescription)
        }
        
        afficherTexte("La nouvelle base a été créée")
    }
    
    func getContext()-> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func creerPersonne(nom: String, prenom: String, age: Int16)-> Personne{
        
        let contexte = getContext()
        
        let personne = NSEntityDescription.insertNewObject(forEntityName: "Personne", into: contexte) as! Personne
        
        personne.nom = nom
        personne.prenom = prenom
        personne.age = age
        
        return personne
    }
    
    func creerAdresse(numero: String, rue: String, ville: String, pays: String)->Adresse{
        
        let contexte = getContext()
        
        let adresse = NSEntityDescription.insertNewObject(forEntityName: "Adresse", into: contexte) as! Adresse
        
        adresse.numero = numero
        adresse.rue = rue
        adresse.ville = ville
        adresse.pays = pays
        
        return adresse
    }
    
    @IBAction func btnInitialiserTouched(_ sender: Any) {
        initialiser()
    }
    @IBAction func btnAfficherContenuTouched(_ sender: Any) {
//        var txt = recupererPersonne()
//        afficherTexte(txt)
        
        var txt = recupererAdresses()
        afficherTexte(txt)
    }
    
    func recupererPersonne()-> String{
        var txt = ""
        
        let contexte = getContext()
        
        let description = NSEntityDescription.entity(forEntityName: "Personne", in: contexte)
        
        let requete: NSFetchRequest<Personne> = Personne.fetchRequest()
        
        requete.entity = description
        
        let descripteurTri1 = NSSortDescriptor(key: "nom", ascending: true)
        let descripteurTri2 = NSSortDescriptor(key: "prenom", ascending: false)
        
        requete.sortDescriptors = [descripteurTri1, descripteurTri2]
        
        do {
           let personnes = try contexte.fetch(requete)
            
            txt += "Les personnes: \n\n"
            for p in personnes{
                txt += "\(p.prenom!) \(p.nom!),age: \(p.age)\n"
                
                let adresses = p.adresses
                if adresses == nil || adresses!.count == 0{
                    txt += "Aucune adresse connue"
                }
                else{
                    txt += "Adresses:"
                    
                    var adresse : Adresse
                    for adr in adresses!
                    {
                        adresse = adr as! Adresse
                        txt += "\n\(adresse.numero!) \(adresse.rue!), \(adresse.ville!), \(adresse.pays!)"
                    }
                }
                
                let conjoint = p.conjoint
                if conjoint == nil{
                    txt += "\nSans Conjoint"
                }
                else{
                    txt += "\nConjoint: \(conjoint!.prenom!) \(conjoint!.nom!)"
                    
                }
                
                let pere = p.pere
                if pere == nil{
                    txt += "\nPère non précisé"
                }
                else{
                    txt += "\nPère: \(pere!.prenom!) \(pere!.nom!)"
                }
                
                let enfants = p.enfants
                if enfants == nil || enfants!.count == 0{
                    txt += "\nPas d'enfant"
                }
                else{
                    txt += "\nEnfants:"
                    
                    for enfant in enfants!
                    {
                        txt += "\n\((enfant as! Personne).prenom!) \((enfant as! Personne).nom!)"
                    }
                }
                
                txt += "\n\n"
                
            }
            return txt
            
        }
        catch let erreur {
            return "La récupération des personnes a échouée"
        }
        
        
    }
    
    func recupererAdresses() -> String {
        var txt = ""
        
        let contexte = getContext()
        
        let description = NSEntityDescription.entity(forEntityName: "Adresse", in: contexte)
        
        let requete: NSFetchRequest<Adresse> = Adresse.fetchRequest()
        
        requete.entity = description
        
        do {
            let adresses = try contexte.fetch(requete)
            
            for adresse in adresses{
                txt += "\n\n\(adresse.numero!) \(adresse.rue!), \(adresse.ville!), \(adresse.pays!)"
                
                let personnes = adresse.personnes
                if personnes == nil || personnes!.count == 0
                {
                    txt += "\n Personne ne vit à cette adresse"
                }
                else{
                    txt += "\nHabitants:"
                    
                    for personne in personnes!
                    {
                        txt += "\n\((personne as! Personne).prenom!) \((personne as! Personne).nom!)"
                    }
                    
                }
            }
            
            return txt
        }
        catch let erreur {
            return "Echec de récupération des adresses: \(erreur.localizedDescription)"
        }
        
    }
    
    @IBAction func btnModifierPersonneTouched(_ sender: Any) {
    }
    @IBAction func btnSupprimerPersonneTouched(_ sender: Any) {
    }
    @IBAction func btnEnleverAdresseTouched(_ sender: Any) {
    }
    @IBAction func btnSelectionnerAdresseTouched(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        txtdisplay.text = ""
    }


}

