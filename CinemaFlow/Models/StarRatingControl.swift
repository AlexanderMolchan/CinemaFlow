//
//  StarRatingControl.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 30.01.23.
//

import Foundation
import UIKit

@IBDesignable
public class StarRating: UIControl {
    
    @IBInspectable lazy public var totalStars: Int = 5
    @IBInspectable lazy public var selectedStars: Int = 1 {
        didSet {
            showStarRating()
        }
    }
    
    lazy private var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    public convenience override init(frame: CGRect) {
        self.init(frame: frame, totalStars: 5, selectedStars: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadStarRating()
    }

    public init(frame: CGRect, totalStars: Int, selectedStars: Int) {
        guard (5...10).contains(totalStars) else {
            fatalError("Please specify total stars value within the range of 3 to 10")
        }
        super.init(frame: frame)
        loadStarRating()
        self.totalStars = totalStars
        self.selectedStars = selectedStars
    }
    
}

extension StarRating {
    private func loadStarRating() {
        addSubview(starStackView)
        starStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        starStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        starStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        starStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        isAccessibilityElement = true
    }
    
    private func showStarRating() {
        for i in 0..<totalStars {
            let starImageName: String = i < selectedStars ? .Symbols.starFill : .Symbols.star
            let starImage = UIImage(named: starImageName)
            if i < starStackView.arrangedSubviews.count, let starImageView = starStackView.arrangedSubviews[i] as? UIImageView {
                starImageView.image = starImage
            } else {
                let starImageView = UIImageView(image: starImage)
                starImageView.contentMode = .scaleAspectFit
                starStackView.addArrangedSubview(starImageView)
            }
        }
        accessibilityLabel = "\(selectedStars) stars selected out of \(totalStars)"
        sendActions(for: .valueChanged)
    }
    
}

// MARK: - Selector methods for touch gesture handler
extension StarRating {
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let xPosition = touch.location(in: self).x
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var xPosition:CGFloat = 0
        
        xPosition += touch.location(in: self).x
        
        if xPosition < 0 {
            xPosition = 0
        }
        if xPosition > bounds.maxX {
            xPosition = bounds.maxX
        }
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    private func calculateNewStars(basedOn position: CGFloat) {
        let newSelectedStars = Int(ceil(position / bounds.width * CGFloat(totalStars)))
        if newSelectedStars != selectedStars {
            selectedStars = newSelectedStars
        }
    }
    
}

extension String {
    enum Symbols {}
}

extension String.Symbols {
    static var star: String { "blueStar" }
    static var starFill: String { "goldStar" }
}
