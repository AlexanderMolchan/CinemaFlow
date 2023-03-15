//
//  OverviewController.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 30.01.23.
//

import UIKit

class OverviewController: UIViewController {
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var secondRateView: UIView!
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateView.layer.cornerRadius = 10
        secondRateView.layer.cornerRadius = 10
        storyView.layer.cornerRadius = 10
    }
    
}
