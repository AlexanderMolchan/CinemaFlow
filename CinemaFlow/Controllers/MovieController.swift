//
//  MovieController.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 27.01.23.
//

import UIKit
import WebKit

class MovieController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributesStack: UIStackView!
    @IBOutlet weak var customSegment: CustomSegmentedControl!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var chooseSeatsOutlet: UIButton!
    
    
    private var webView = WKWebView()
    private var controllers = [UIViewController]()
    private var selectedSegmentIndex = 0
    var movie = MovieModel()
    var attributesArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configurate() {
        self.view.backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)
        chooseSeatsOutlet.layer.cornerRadius = 14
        playerView.alpha = 0
        
        chooseSeatsOutlet.layer.shadowColor = UIColor.black.cgColor
        chooseSeatsOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 40.0)
        chooseSeatsOutlet.layer.shadowOpacity = 0.5
        chooseSeatsOutlet.layer.shadowRadius = 3.0
        chooseSeatsOutlet.layer.masksToBounds = false
        
        webView.navigationDelegate = self
        bannerImage.image = movie.banner
        bannerImage.layer.cornerRadius = 10
        nameLabel.text = movie.name
        attributeLabelsCreate()
        segmentSettings()
        configurateControllers()
        insertController()
    }
    
    private func segmentSettings() {
        customSegment.setButtonTitles(buttonTitles: ["Overview", "Feedbacks"])
        customSegment.selectorTextColor = .white
        customSegment.selectorViewColor = UIColor(red: 0.373, green: 0.217, blue: 1, alpha: 1)
        customSegment.textColor = UIColor(red: 0.239, green: 0.208, blue: 0.565, alpha: 1)
        customSegment.backgroundColor = .clear
        customSegment.delegate = self
    }
    
    private func moviePlayerCreate() {
        let webConfig = WKWebViewConfiguration()
        webConfig.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: self.playerView.bounds, configuration: webConfig)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        playerView.backgroundColor = .clear
        guard let stringUrl = self.movie.urlString,
              let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        self.playerView.addSubview(webView)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.webView.load(request)
        }
        self.playerView.alpha = 1
    }
    
    private func attributeLabelsCreate() {
        attributesStack.spacing = 17
        attributesArray.forEach { attribute in
            let label = UILabel()
            label.font = UIFont(name: "Hiragino Sans W6", size: 12)
            label.textColor = .white
            label.text = attribute
            self.attributesStack.addArrangedSubview(label)
        }
    }
    
    private func configurateControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let overviewVc = storyboard.instantiateViewController(withIdentifier: String(describing: OverviewController.self)) as? OverviewController,
              let feedbacksVc = storyboard.instantiateViewController(withIdentifier: String(describing: FeedbacksController.self)) as? FeedbacksController else { return }
        controllers.append(overviewVc)
        controllers.append(feedbacksVc)
    }
    
    private func insertController() {
        let childVc = self.children
        childVc.forEach { vc in
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        let controller = controllers[selectedSegmentIndex]
        self.addChild(controller)
        controller.view.frame = self.container.bounds
        self.container.addSubview(controller.view)
        self.didMove(toParent: controller)
    }
    
    @IBAction func playTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.playButtonOutlet.alpha = 0
            self.bannerImage.alpha = 0
        } completion: { isFinish in
            guard isFinish else { return }
            self.playButtonOutlet.isHidden = true
            self.bannerImage.isHidden = true
            self.moviePlayerCreate()
        }
    }
    
    
    @IBAction func sharedDidTap(_ sender: Any) {
        let message = "Hello, it is my new app!"
        guard let stringUrl = movie.urlString else { return }
        if let link = NSURL(string: stringUrl) {
            let objectsToShare = [message, link] as [Any]
            let activityVc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    //        activityVc.excludedActivityTypes = [.airDrop, .addToReadingList, .message, .assignToContact]
            present(activityVc, animated: true)
            activityVc.view.backgroundColor = UIColor(red: 0.075, green: 0.059, blue: 0.129, alpha: 1)

        }
    }
    
}

extension MovieController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard let stringUrl = self.movie.urlString,
              let url = URL(string: stringUrl) else { return }
        if webView.url?.absoluteString != stringUrl {
            webView.load(URLRequest(url: url))
        }
    }
    
}


extension MovieController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        selectedSegmentIndex = index
        insertController()
    }
}

