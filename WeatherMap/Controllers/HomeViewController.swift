//
//  ViewController.swift
//  WeatherMap
//
//  Created by Pedro Grando on 24/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    var weather: Weather?
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var cityOfBrazil: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApi(city: "Porto Alegre")
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        let userText = searchBar.text ?? ""
        getApi(city: userText)
        cityOfBrazil.text = userText
        searchBar.text = ""
    }
    
    func getApi(city: String) {
        
        let city = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city),br&units=metric&appid=aeefba332b49db396d425480b21571b2")
        
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data, error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        let weather = try decoder.decode(Weather.self, from: data)
                        
                        self.weather = weather
                        
                        print(weather.name)
                        
                        
                        DispatchQueue.main.async {
                            
                            self.temperature.text = String(format: "%.f" , weather.main.temp)
                            self.cityOfBrazil.text = String(weather.name)
                        }
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            task.resume()
        }

    }

    
    
    
}

