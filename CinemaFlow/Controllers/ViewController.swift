//
//  ViewController.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 26.01.23.
//

import UIKit

class ViewController: UIViewController, ChooseTimeDelegate {
    
    @IBOutlet weak var cinemaField: UIView!
    @IBOutlet weak var cinemaChooseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cinemaNameLabel: UILabel!
    @IBOutlet weak var cinemaDistanceLabel: UILabel!
    
    private var movieArray = [MovieModel]()
    private var cinemaList = [CinemaModel]()
    private var cinemaSelectedIndex = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
        tableViewSets()
    }
    
    private func configureUI() {
        navigationController?.isNavigationBarHidden = true
        cinemaField.layer.cornerRadius = 11
        cinemaChooseButton.layer.cornerRadius = 11
    }
    
    private func tableViewSets() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieCell.id, bundle: nil), forCellReuseIdentifier: MovieCell.id)
    }
    
    private func getData() {
        movieArray = MovieModel.getMoviesData()
        cinemaList = CinemaModel.getCinemaData()
    }
    
    func pushToVc(movie: MovieModel, attributes: [String]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieVc = storyboard.instantiateViewController(withIdentifier: String(describing: MovieController.self)) as? MovieController else { return }
        movieVc.movie = movie
        movieVc.attributesArray = attributes
        navigationController?.present(movieVc, animated: true)
    }
    
    @IBAction func chooseCinemaDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let chooseCinemaVc = storyboard.instantiateViewController(withIdentifier: String(describing: CinemaListController.self)) as? CinemaListController else { return }
        chooseCinemaVc.modalPresentationStyle = .pageSheet
        guard let sheet = chooseCinemaVc.sheetPresentationController else { return }
        sheet.detents = [.custom(resolver: { context in
            guard let screen = self.view.window?.windowScene?.screen else { return .zero }
            let customHeight = screen.bounds.height * 0.567
            return customHeight
        })]
        chooseCinemaVc.cinemaList = cinemaList
        chooseCinemaVc.selectedCinemaIndex = cinemaSelectedIndex
        chooseCinemaVc.cinemaChangeClousure = { cinema, index in
            self.cinemaNameLabel.text = cinema.name
            self.cinemaDistanceLabel.text = cinema.distance
            self.cinemaSelectedIndex = index
        }
        navigationController?.present(chooseCinemaVc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath)
        guard let movieCell = cell as? MovieCell else { return cell }
        
        movieCell.set(movie: movieArray[indexPath.row])
        movieCell.delegate = self
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 50, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}

protocol ChooseTimeDelegate: AnyObject {
    func pushToVc(movie: MovieModel, attributes: [String])
}
