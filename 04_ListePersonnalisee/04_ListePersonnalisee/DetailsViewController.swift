//
//  DetailsViewController.swift
//  04_ListePersonnalisee
//
//  Created by Etudiant on 18/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var gateau_a_afficher: Gateau = Gateau(nom: "", nomImage: "", description: "")
    
    @IBAction func btnRetourTouched(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
