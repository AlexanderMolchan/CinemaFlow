//
//  CinemaChooseCell.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 27.01.23.
//

import UIKit

class CinemaChooseCell: UITableViewCell {
    static let id = String(describing: CinemaChooseCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)
    }
    
    func set(cinema: CinemaModel) {
        nameLabel.text = cinema.name
        distanceLabel.text = cinema.distance
        if self.isSelected {
            containerView.backgroundColor = UIColor(red: 0.21, green: 0.17, blue: 0.52, alpha: 1)
            nameLabel.textColor = .orange
        } else {
            nameLabel.textColor = .white
            containerView.backgroundColor = .clear
        }
    }
    

    
    private func animationBackColor() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.containerView.backgroundColor = UIColor(red: 0.21, green: 0.17, blue: 0.52, alpha: 1)
        }
    }
    
}
