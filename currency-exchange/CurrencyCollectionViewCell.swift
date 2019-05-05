//
//  CurrencyCollectionViewCell.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 05/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var exchangeValueTextField: UITextField!
    @IBOutlet weak var currentBalanceOfThisCurrencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.currencyView.layer.cornerRadius = 13.0
            self.currencyView.layer.shadowColor = UIColor.lightGray.cgColor
            self.currencyView.layer.shadowOpacity = 10.0
            self.currencyView.layer.shadowOffset = .zero
            self.currencyView.layer.shadowPath = UIBezierPath(rect: self.currencyView.bounds).cgPath
            self.currencyView.layer.shouldRasterize = true
        }
    }

}
