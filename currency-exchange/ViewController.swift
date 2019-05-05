//
//  ViewController.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 05/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    @IBOutlet weak var currencyCollectionView2: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setup(collectionView: currencyCollectionView)
        setup(collectionView: currencyCollectionView2)
        
//        let floawLayout = UPCarouselFlowLayout()
//        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: currencyColletionView.frame.size.height)
//        floawLayout.scrollDirection = .horizontal
//        floawLayout.sideItemScale = 0.8
//        floawLayout.sideItemAlpha = 1.0
//        floawLayout.spacingMode = .fixed(spacing: 5.0)
//        currencyColletionView.collectionViewLayout = floawLayout
//
//        currencyColletionView.delegate = self
//        currencyColletionView.dataSource = self
    }
    
    private func setup(collectionView cv: UICollectionView){
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: cv.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        cv.collectionViewLayout = floawLayout
        
        cv.delegate = self
        cv.dataSource = self
    }
    
    //MARK: UICollectionViewDelegate and UICollectionViewDataSource
    
    let currencies = ["EUR", "USD", "GBP"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cellRaw = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.identifier, for: indexPath)
        
        let cell = cellRaw as! CurrencyCollectionViewCell
        
        cell.currencyNameLabel.text = currencies[indexPath.row]
        cell.currentBalanceOfThisCurrencyLabel.text = "You have: 100.00"
        cell.exchangeValueTextField.text = "0"
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected == \(indexPath.row)")
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

