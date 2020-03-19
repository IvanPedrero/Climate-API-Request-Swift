//
//  ViewController.swift
//  Yahoo Climate Request
//
//  Created by Ivan Pedrero on 3/19/20.
//  Copyright © 2020 Ivan Pedrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var cities:Array<Array<String>> = Array<Array<String>>()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row][0]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(self.cities[row][1] == ""){
            cityLabel.text = ""
            temperatureLabel.text = ""
            return
        }
        
        let urls = "http://api.openweathermap.org/data/2.5/weather?q="
        let url = NSURL(string: urls + self.cities[row][1] + "&APPID=dd4200c957b11f2f9e10633ecea2eed5")

        let data = NSData(contentsOf: url as! URL)
        
        do{
            let json = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let dict = json as! NSDictionary
            
            cityLabel.text = dict["name"] as! NSString as! String
            
            let mainDict = dict["weather"] as! [[String:Any]]
            let weatherDict = mainDict[0] as! NSDictionary
            
            temperatureLabel.text = weatherDict["description"] as! NSString as! String
        }
        catch _{
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cities.append(["Choose a city...", ""])
        cities.append(["Hong Kong", "HONG%20KONG"])
        cities.append(["Paris", "PARIS"])
        cities.append(["London", "LONDON"])
    }


}

