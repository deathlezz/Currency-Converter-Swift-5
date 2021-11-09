//
// Currency Converter
//
// Created by deathlezz on 8/08/2021.
//
// https://api.frankfurter.app/latest?from=USD

import Foundation

// available currencies array
let currency = ["USD", "EUR", "JPY", "GBP"]

func convert(base: String, to: String, amount: Float) {

    // specify how the json file looks like
    struct Json: Codable {
        let base: String
        let rates: [String: Float]
    }

    // create url
    if let url = URL(string: "https://api.frankfurter.app/latest?from=\(base)") {

        do {
            // make http GET call
            let contents = try String(contentsOf: url)

            // specify decoding format
            let data = contents.data(using: .utf8)

            // decode json data
            let ratesData = try JSONDecoder().decode(Json.self, from: data!)

            if base != to {
                // multiply amount by rate
                let multiply = amount * ratesData.rates["\(to)"]!
            
                // output
                print("\(amount) \(base) = \(multiply) \(to)")
            }
        } catch {
            print("* Connection error *")
        }
    } else {
        print("* Invalid URL *")
    }
}

print("* Welcome to Currency Converter *")

func enterBase() {
    print()
    print("Enter base currency: [USD, EUR, JPY, GBP]")

    let base = readLine()!.uppercased()
        
    if base == "USD" || base == "EUR" || base == "JPY" || base == "GBP" {

        func enterAmount() {
            print()
            print("Enter amount:")

            if let number = Float(readLine()!) {
                
                if number > 0 {
                    print()
                    
                    // call the function
                    for name in currency {
                        convert(base: base!, to: name, amount: number)
                    }
                    return enterBase()
                    
                } else {
                    print()
                    print("* Enter value bigger than 0 *")
                    return enterAmount()
                }
                    
            } else {
                print()
                print("* Enter numbers only *")
                return enterAmount()
            }
        }
        enterAmount()
        
    } else {
        print()
        print("* Enter USD, EUR, JPY or GBP *")
        return enterBase()
    }
}
enterBase()

// 5.0 GBP = 6.9585 USD
// 5.0 GBP = 5.8935 EUR
// 5.0 GBP = 764.05 JPY
