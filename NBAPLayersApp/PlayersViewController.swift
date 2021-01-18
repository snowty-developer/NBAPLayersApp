//
//  PlayersViewController.swift
//  NBAPLayersApp
//
//  Created by Александр Зубарев on 24.12.2020.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var players: [Player] = []
    let apiClient: ApiClient = ApiClientImpl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Players"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        reload()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        let player = players[indexPath.row]
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.team.fullName
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerDetailsVC = storyboard!.instantiateViewController(identifier: "PlayerDetails") as! PlayerDetailsViewController

        let player = players[indexPath.row]
        playerDetailsVC.player = player
        
        navigationController?.pushViewController(playerDetailsVC, animated: true)
    }
    
    @IBAction func reloadButtonClick(_ sender: Any) {
        reload()
    }
    
    private func reload() {
        showLoading()
        apiClient.getPlayers(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self.players = players
                    self.showData()
                case .failure:
                    self.players = []
                    self.showError()
                }
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        })
    }
    
    private func showLoading() {
        activityIndicatorView.startAnimating()
        reloadButton.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func showData() {
        activityIndicatorView.stopAnimating()
        reloadButton.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func showError() {
        activityIndicatorView.stopAnimating()
        reloadButton.isHidden = false
        errorLabel.isHidden = false
    }
}
