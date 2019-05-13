//
//  Account.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class Account {
    var currencyName: CurrencyName
    var value: Double
    
    init(name: CurrencyName, value: Double) {
        self.currencyName = name
        self.value = value
    }
}


