//
//  Currency Converter (formula)
//
//  Created by deathlezz on 6/08/2021.
//
//  https://api.frankfurter.app/latest?from=USD

import Foundation

// specify how the json file looks like
struct Json: Codable {
    let base: String
    let rates: [String: Float]
}

// create function
func convert(from: String, to: String, amount: Float) {

    // create url
    let url = URL(string: "https://api.frankfurter.app/latest?from=\(from)")
    
    do {
        // make http (get) call
        let contents = try String(contentsOf: url!)

        // specify decoding format
        let data = contents.data(using: .utf8)

        // decode json data
        let ratesData = try JSONDecoder().decode(Json.self, from: data!)

        // multiply value with rate
        let calculate = amount * ratesData.rates[to]!
        
        // output
        print("\(amount) \(ratesData.base) = \(calculate) \(to)")
        print("Rate: \(ratesData.rates[to]!)")
        
    } catch {
        print("* Probably connection error *")
    }
}

convert(from: "GBP", to: "PLN", amount: 10)

// 10.0 GBP = 53.498997 PLN
// Rate: 5.3499
