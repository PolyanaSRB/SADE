//
//  PatientViewController.swift
//  Monitor
//
//  Created by user174461 on 6/10/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the hospital patients' list screen, which can be added as monitored
class HospitalPatientsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // TODO: same as controller of user's patients, get the hospital patients that is not being monitored and show it here
    
    @IBOutlet weak var tableView: UITableView!
    var pacients:[String] = ["Abelardo Bueno", "Joana Angélica", "Jorge Emílio", "José Bandeirantes", "Lúcio Costa", "Marina Freitas", "Maria Antonieta", "Paloma Duarte"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pacients.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pacients[indexPath.row]

        return cell
    }

}





































