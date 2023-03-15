//
//  TimeCell.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 27.01.23.
//

import UIKit

class TimeCell: UICollectionViewCell {
    static let id = String(describing: TimeCell.self)
    
    @IBOutlet weak var cellLabel: UILabel!
    
    weak var delegate: ChooseTimeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(time: String) {
        cellLabel.text = time
        cellLabel.textColor = .white
        backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 0.267, green: 0.188, blue: 0.631, alpha: 1)
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
    
}
  
