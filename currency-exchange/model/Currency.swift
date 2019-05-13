//
//  Currency.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation


struct Currency: Codable {
    var base : String
    var rates : [String: Double]
}

enum CurrencyName : String {
    case eur = "EUR"
    case usd = "USD"
    case gbp = "GBP"
    
    func sign() -> String {
        switch self {
            
        case .eur: return "€"
        case .usd: return "$"
        case .gbp: return "£"
            
        }
    }
}

