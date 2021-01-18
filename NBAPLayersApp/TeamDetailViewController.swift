//
//  TeamDetailViewController.swift
//  NBAPLayersApp
//
//  Created by Александр Зубарев on 18.01.2021.
//

import UIKit

class TeamDetailViewController: UIViewController {

    var team: Team?
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conferenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityLabel.text = team?.city
        conferenceLabel.text = team?.conference
        navigationItem.title = team?.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}
