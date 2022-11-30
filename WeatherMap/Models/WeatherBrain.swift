//
//  WeatherBrain.swift
//  WeatherMap
//
//  Created by Pedro Grando on 30/11/22.
//

import Foundation

protocol WeatherBrainDelegate {
    func requestSuccess(weatherData: Weather?)
    func requestFail(error: Error)
}

struct WeatherBrain {
    
    var delegate : WeatherBrainDelegate?
    
    
    
    func getApi(city: String) {
        
        let city = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city),br&units=metric&appid=aeefba332b49db396d425480b21571b2")
        
        if let url = url {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error == nil {
                    if data != nil {
                        let weather = self.decodeJSON(data!)
                        self.delegate?.requestSuccess(weatherData: weather)
                    }
                    
                } else {
                    self.delegate?.requestFail(error: error!)
                }
            }
            
            task.resume()
        }
    
    }
    
    func decodeJSON(_ dataOfWeather: Data) -> Weather? {
        let decoder = JSONDecoder()
        
        do {
            let weather = try decoder.decode(Weather.self, from: dataOfWeather)
            
            return weather
        }
        catch {
            self.delegate?.requestFail(error: error)
            return nil
        }
    }
}
