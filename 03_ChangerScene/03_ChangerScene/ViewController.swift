//
//  ViewController.swift
//  03_ChangerScene
//
//  Created by Etudiant on 17/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var txtControlerOne :String! = ""
    @IBOutlet weak var txtSaisie: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        txtSaisie.text = txtControlerOne
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        print("Un segue démarre")
        
        let destination = segue.destination
        
        if destination is ViewController2{
            let dest = destination as! ViewController2
        }
        
        if destination is ViewController4{
            let dest = destination as! ViewController4
            dest.screen1 = self
        }
    }
    
    @IBAction func btnAllerPage3Touched(_ sender: Any) {
        
        let controleurDestination = storyboard?.instantiateViewController(withIdentifier: "idEcran3") as! ViewController3
        
        
        present(controleurDestination, animated: true, completion: {print("Passage vers ViewController3") })
    }
    
    @IBAction func retourEcran4VersEcran1(segue: UIStoryboardSegue) {
        
        print("Execution de la fonctione retourEcran4versEcran1")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

