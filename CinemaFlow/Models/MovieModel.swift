//
//  MovieModel.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 26.01.23.
//

import Foundation
import UIKit

class MovieModel {
    var name: String?
    var subName: String?
    var duration: String?
    var ageLimit: String?
    var genre: String?
    var subGenre: String?
    var type: String?
    var movieDate: [String]?
    var image = UIImage()
    var gradient: CGColor?
    var urlString: String?
    var banner = UIImage()
    
    init(name: String, subname: String? = nil, duration: String, ageLimit: String, genre: String? = nil, subGenre: String, type: String, movieDate: [String], image: UIImage?, gradient: CGColor, urlString: String, banner: UIImage?) {
        self.name = name
        self.subName = subname
        self.duration = duration
        self.ageLimit = ageLimit
        self.genre = genre 
        self.subGenre = subGenre
        self.type = type
        self.movieDate = movieDate
        self.image = image ?? UIImage(systemName: "gear")!
        self.gradient = gradient
        self.urlString = urlString
        self.banner = banner ?? UIImage(systemName: "gear")!
    }
    
    init() {
    }
    
    static func getMoviesData() -> [MovieModel] {
        var movies: [MovieModel] = []
        let dateArray = ["08.20 PM", "09.40 PM", "11.20 PM", "03.49 AM", "07.00 AM"]
        let rayaImage = UIImage(named: "rayaImage")
        let strangageImage = UIImage(named: "strangage")
        let dunaImage = UIImage(named: "kallSobaki")
        let pussImage = UIImage(named: "pussInBoots")
        
        let rayaMovie = MovieModel(name: "RAYA AND THE LAST DRAGON", duration: "147 min", ageLimit: "6+", genre: "animation", subGenre: "action", type: "drama", movieDate: dateArray, image: rayaImage, gradient: UIColor.systemBlue.cgColor, urlString: "https://www.youtube.com/embed/1VIZ89FEjYI?playsinline=1", banner: UIImage(named: "rayaBanner"))
        
        let strangageMovie = MovieModel(name: "DOCTOR STRANGE", subname: "in the Multiverse of Madness", duration: "200 min", ageLimit: "12+", subGenre: "action", type: "drama", movieDate: dateArray, image: strangageImage, gradient: UIColor.red.cgColor, urlString: "https://www.youtube.com/embed/aWzlQ2N6qqg", banner: UIImage(named: "strangeBanner"))
        
        let dunaMovie = MovieModel(name: "DUNE", duration: "140 min", ageLimit: "12+", subGenre: "action", type: "drama", movieDate: dateArray, image: dunaImage, gradient: UIColor.white.cgColor, urlString: "https://www.youtube.com/embed/8g18jFHCLXk", banner: UIImage(named: "duneBanner"))
        
        let puss = MovieModel(name: "Puss in Boots", subname: "the last wish", duration: "90 min", ageLimit: "12+", genre: "animation", subGenre: "action", type: "comedy", movieDate: dateArray, image: pussImage, gradient: UIColor.orange.cgColor, urlString: "https://www.youtube.com/embed/tHb7WlgyaUc", banner: UIImage(named: "pussBanner"))
        
        movies.append(rayaMovie)
        movies.append(strangageMovie)
        movies.append(dunaMovie)
        movies.append(puss)

        return movies
    }
    
}
