//
//  CinemaListController.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 27.01.23.
//

import UIKit

class CinemaListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okeyButtonOutlet: UIButton!
    
    var cinemaList = [CinemaModel]()
    var cinemaChangeClousure: ((CinemaModel, IndexPath) -> ())?
    var selectedCinemaIndex = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
    }
    
    private func tableViewSettings() {
        self.view.backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CinemaChooseCell.id, bundle: nil), forCellReuseIdentifier: CinemaChooseCell.id)
        
        okeyButtonOutlet.layer.cornerRadius = 14
    }
    
    
    @IBAction func disMissTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func changeCinemaTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension CinemaListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cinemaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CinemaChooseCell.id, for: indexPath)
        guard let cinemaCell = cell as? CinemaChooseCell else { return cell }
        
        cinemaCell.isSelected = indexPath == selectedCinemaIndex
        cinemaCell.set(cinema: cinemaList[indexPath.row])
        
        return cinemaCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCinemaIndex = indexPath
        cinemaChangeClousure?(cinemaList[indexPath.row], indexPath)
        tableView.performBatchUpdates {
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
