//
//  Currency.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class Converter {
    
    private var currency: Currency? = nil
    
    init() {
        updateCurrency()
    }
    
    private func updateCurrency() {
        GetCurrency().execute(
            onSuccess: {(currency: Currency) in
                self.currency = currency
            },
            onError: {(error: Error) in
                error.printDescription()
            }
        )
    }
    
    func rate(value: Double, from: CurrencyName, to: CurrencyName) -> Double {
        if from == to {
            return value
        }
        
        if from == .eur {
            guard let coef = currency?.rates[to.rawValue] else { return 1 }
            return (value * coef).rounded(toPlaces: 3)
        }
        
        // croos rates
        
        let rateFrom = currency?.rates[from.rawValue] ?? 1
        let rateTo = currency?.rates[to.rawValue] ?? 1
        
        let res = value * (rateTo / rateFrom)
        return res.rounded(toPlaces: 3)
        
    }
    
}
