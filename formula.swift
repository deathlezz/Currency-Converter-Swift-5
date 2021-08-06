//
//  Currency Converter (formula)
//
//  Created by deathlezz on 6/08/2021.
//
//  https://v6.exchangerate-api.com/v6/b7069835f198cb7389c14e62/latest/USD

import Foundation

// specify how the json file looks like
struct json: Codable {
    let base_code: String
    let conversion_rates: [String: Float]
}

// create function
func convert(from: String, to: String, amount: Float) {

    // create url
    let url = URL(string: "https://v6.exchangerate-api.com/v6/b7069835f198cb7389c14e62/latest/\(from)")
    
    do {
        // make http (get) call
        let contents = try String(contentsOf: url!)

        // specify decoding format
        let data = contents.data(using: .utf8)

        // decode json data
        let ratesData = try JSONDecoder().decode(json.self, from: data!)

        // multiply value with rate
        let calculate = amount * ratesData.conversion_rates[to]!
        
        // output
        print("\(amount) \(ratesData.base_code) = \(calculate) \(to)")
        print("Rate: \(ratesData.conversion_rates[to]!)")
        
    } catch {
        print("* Probably connection error *")
    }
}

convert(from: "GBP", to: "PLN", amount: 10)

// 10.0 GBP = 53.498997 PLN
// Rate: 5.3499
