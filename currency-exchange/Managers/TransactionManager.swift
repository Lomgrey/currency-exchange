//
//  TransactionManager.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class TransactionManager {
    
    private let converter = Converter()
    
    func doTransaction(_ transaction: Transaction) throws {
        if transaction.sourceAccount.value < transaction.amount {
            throw TransactionError.insufficientFunds
        }
        
        let transferAmount = converter.rate(
            value: transaction.amount,
            from: transaction.sourceAccount.currencyName,
            to: transaction.destinationAccount.currencyName)
        
        transaction.sourceAccount.value -= transaction.amount
        transaction.destinationAccount.value += transferAmount
    }
    
}

enum TransactionError: Error {
    case insufficientFunds
}
