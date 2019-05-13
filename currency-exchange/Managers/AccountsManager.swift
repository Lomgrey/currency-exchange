//
//  AccountsManager.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class AccountsManager {
    let eurAccount = Account(name: .eur, value: 100)
    let usdAccount = Account(name: .usd, value: 100)
    let gbpAccount = Account(name: .gbp, value: 100)
    
    lazy var accounts = [eurAccount, usdAccount, gbpAccount]
}
