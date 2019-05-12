//
//  AccountsManager.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class AccountsManager {
    let eurAccount = Account(name: "EUR", value: 80)
    let usdAccount = Account(name: "USD", value: 33)
    let gbpAccount = Account(name: "GBP", value: 170)
    
    lazy var accounts = [eurAccount, usdAccount, gbpAccount]
}
