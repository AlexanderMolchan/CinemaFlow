//
//  FeedbacksController.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 30.01.23.
//

import UIKit

class FeedbacksController: UIViewController {
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var opinionView: UIView!
    @IBOutlet var starButtonsArray: [UIButton]!
    
    private var currentTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
    }
    
    private func configurate() {
        self.view.backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)
        rateView.layer.cornerRadius = 10
        opinionView.layer.cornerRadius = 10
        starButtonsArray.forEach { button in
            button.setImage(UIImage(named: "goldStar"), for: .highlighted)
        }
    }
    
    @IBAction func starTapped(_ sender: UIButton) {
        self.currentTag = sender.tag - 1000
        starButtonsArray.forEach { button in
            button.imageView?.image = UIImage(named: "blueStar")
        }
        for i in 0...currentTag {
            starButtonsArray[i].imageView?.image = UIImage(named: "goldStar")
        }
    }
    
}
