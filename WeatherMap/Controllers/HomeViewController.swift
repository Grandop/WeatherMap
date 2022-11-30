//
//  ViewController.swift
//  WeatherMap
//
//  Created by Pedro Grando on 24/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var cityOfBrazil: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    var weather: Weather?
    var weatherBrain = WeatherBrain()
    
    
    func hideLoading() {
        self.loadingView.isHidden = true
        self.loaderIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func showLoading() {
        self.loadingView.isHidden = false
        self.loadingView.backgroundColor?.withAlphaComponent(0.5)
        self.loaderIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
        searchBar.delegate = self
        weatherBrain.delegate = self
        weatherBrain.getApi(city: "Porto Alegre")
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        let userText = searchBar.text ?? ""
        weatherBrain.getApi(city: userText)
        showLoading()
        searchBar.text = ""
    }
    
}

