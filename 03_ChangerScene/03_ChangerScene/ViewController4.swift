//
//  ViewController4.swift
//  03_ChangerScene
//
//  Created by Etudiant on 17/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    var screen1:ViewController! = nil

    @IBOutlet weak var txtSaisi4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSaisi4.text = screen1.txtSaisie.text
        

        // Do any additional setup after loading the view.
    }

    @IBAction func retourChangement(_ sender: Any) {
        
        screen1.txtControlerOne = txtSaisi4.text
        
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
