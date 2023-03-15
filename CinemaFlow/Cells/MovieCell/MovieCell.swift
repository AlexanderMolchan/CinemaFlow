//
//  MovieCell.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 26.01.23.
//

import UIKit

class MovieCell: UITableViewCell {
    static let id = String(describing: MovieCell.self)
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameStackView: UIStackView!
    
    private var timeArray = [String]()
    private var attributesArray = [String]()
    private var movie: MovieModel?
    weak var delegate: ChooseTimeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = UIColor.clear
        cellImage.layer.cornerRadius = 8
        collectionViewConfigurate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func collectionViewConfigurate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TimeCell.id, bundle: nil), forCellWithReuseIdentifier: TimeCell.id)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        stackView.spacing = 17
    }
    
    func set(movie: MovieModel) {
        guard let movieDate = movie.movieDate else { return }
        self.timeArray = movieDate
        self.movie = movie
        cellImage.image = movie.image
        nameLabel.text = movie.name
        if attributesArray.isEmpty {
            attributesArray.append(movie.ageLimit ?? "")
            attributesArray.append(movie.duration ?? "")
            attributesArray.append(movie.type ?? "")
            attributesArray.append(movie.genre ?? "")
            attributesArray.append(movie.subGenre ?? "")
            setGradient(color: movie.gradient ?? UIColor.white.cgColor)
            stackSets()
            addSubname(movie.subName)
        }
    }
    
    private func addSubname(_ subname: String?) {
        if let subname = subname {
            let label = UILabel()
            label.text = subname
            label.font = UIFont(name: "Hiragino Sans W7", size: 12)
            label.textColor = .white
            nameStackView.alignment = .center
            nameStackView.addArrangedSubview(label)
        }
    }
    
    private func stackSets() {
        attributesArray.enumerated().forEach { index, but in
            if but == "" {
                self.attributesArray.remove(at: index)
            }
        }
        attributesArray.forEach { attribute in
            let label = UILabel()
            label.font = UIFont(name: "Hiragino Sans W6", size: 12)
            label.textColor = .white
            label.text = attribute
            label.baselineAdjustment = .alignBaselines
            self.stackView.addArrangedSubview(label)
        }
    }
    
    private func setGradient(color: CGColor) {
        let view = UIView(frame: cellImage.frame)
        let gradient = CAGradientLayer()
        gradient.frame = cellImage.frame
        gradient.colors = [UIColor.clear.cgColor, color]
        gradient.locations = [0.2, 0.9]
        view.layer.insertSublayer(gradient, at: 0)
        cellImage.addSubview(view)
        cellImage.bringSubviewToFront(view)
    }

}

extension MovieCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timeArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCell.id, for: indexPath)
        guard let timeCell = cell as? TimeCell else { return cell }
        timeCell.set(time: timeArray[indexPath.row])
        timeCell.delegate = delegate
        return timeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeCell,
              let movie = movie else { return }
        cell.delegate?.pushToVc(movie: movie, attributes: attributesArray)
    }

}

extension MovieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let screen = window?.windowScene?.screen else { return .zero }
        let width = (screen.bounds.width) / 2.5
        return CGSize(width: width, height: 69)
    }
}
