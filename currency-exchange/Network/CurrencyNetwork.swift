//
//  CurrencyNetwork.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class GetCurrency: RequestType {
    typealias ResponseType = Currency
    var data: RequestData {
        return RequestData(path: "https://api.exchangeratesapi.io/latest", method: .get)
    }
}
