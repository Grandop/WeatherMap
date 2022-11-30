//
//  extensionDelegate.swift
//  WeatherMap
//
//  Created by Pedro Grando on 30/11/22.
//

import Foundation
import UIKit

//MARK: UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Digite uma cidade"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let userText = searchBar.text ?? ""
        weatherBrain.getApi(city: userText)
        showLoading()
        searchBar.text = ""
    }
    
}

//MARK: WeatherBrainDelegate

extension HomeViewController: WeatherBrainDelegate {
    func requestSuccess(weatherData: Weather?) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.temperature.text = weatherData?.tempFomat ?? ""
            self.cityOfBrazil.text = weatherData?.name
        }
    }
    
    func requestFail(error: Error) {
        DispatchQueue.main.async {
            
            let alertMessage = UIAlertController(title: "Ocorreu um erro!", message: "Não conseguimos encontrar sua cidade, desculpe", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Fechar", style: .cancel))
            self.present(alertMessage, animated: true)
            self.hideLoading()
            print(error)
        }
    }
    
}
