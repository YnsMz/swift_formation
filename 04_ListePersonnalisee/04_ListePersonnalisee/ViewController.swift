//
//  ViewController.swift
//  04_ListePersonnalisee
//
//  Created by Etudiant on 17/04/2018.
//  Copyright © 2018 Ipssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var maTable: UITableView!
    var tbGateaux: [Gateau] = [Gateau]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbGateaux.append(Gateau(nom:"Tiramisu", nomImage:"tiramisu.jpg", description:"Tiramisu au chocolat, aux fruits rouges, mangue/passion ou au caramel"))
        
        tbGateaux.append(Gateau(nom:"Tarte aux pêches", nomImage:"tartePeches.jpg", description:"Tarte aux pêches blanches fraiches"))
        
        tbGateaux.append(Gateau(nom:"Gateau au chocolat", nomImage:"gateauChocolat.jpg", description:"Moelleux au chocolat saupoudrés de sucre glace"))
        
        tbGateaux.append(Gateau(nom:"Meringue", nomImage:"meringue.jpg", description:"Meringue aux fruits"))
        
        maTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbGateaux.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellule: MaCellule = tableView.dequeueReusableCell(withIdentifier: "maCellulePersonnalisee", for: indexPath) as! MaCellule
        
        let gateau = tbGateaux[indexPath.row]
        
        cellule.etqTitre.text = gateau.nom
        cellule.etqDescription.text = gateau.description
        cellule.imgGateau.image = UIImage(named: gateau.nomImage)
        
        return cellule
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

