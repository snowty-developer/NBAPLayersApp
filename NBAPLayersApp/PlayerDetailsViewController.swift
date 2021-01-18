//
//  PlayerDetailsViewController.swift
//  NBAPLayersApp
//
//  Created by Александр Зубарев on 24.12.2020.
//

import UIKit

class PlayerDetailsViewController: UIViewController {

    var player: Player?
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = player?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        positionLabel.text = player?.position
        heightLabel.text = player?.height
        teamButton.setTitle(player?.team.fullName, for: .normal)
    }
    
    @IBAction func openTeamDetail(_ sender: Any) {
        let teamDetailsVC = storyboard!.instantiateViewController(identifier: "TeamDetails") as! TeamDetailViewController
        
        teamDetailsVC.team = player?.team
        navigationController?.pushViewController(teamDetailsVC, animated: true)
    }

}
