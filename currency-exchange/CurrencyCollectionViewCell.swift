//
//  CurrencyCollectionViewCell.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 05/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrencyIdentifier"
    
    
//    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var exchangeValueTextField: UITextField!
    @IBOutlet weak var currentBalanceOfThisCurrencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 13.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 10.0
        self.layer.shadowOffset = .zero
        self.layer.shouldRasterize = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
