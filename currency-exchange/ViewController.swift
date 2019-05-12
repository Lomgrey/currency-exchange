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
    
    private let accountsManager = AccountsManager()
    
    private var currentSourceAccount : Account?
    private var currentDestinationAccount : Account?
    
    private var currentSourceCell : CurrencyCollectionViewCell?
    private var currentDestinationCell : CurrencyCollectionViewCell?
    
    private let currency = Currency()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setup(collectionView: currencyCollectionView)
        setup(collectionView: currencyCollectionView2)
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
    
    @IBAction func exchangeAction(_ sender: Any) {
    }
    
    @IBAction func sourceTransactionValueChanged(_ sender: UITextField) {
        let sourceValueText = sender.text
        let sourceValue = Double(sourceValueText!) ?? Double(0)
        
        let destinationValue = currency.rate(
            value: sourceValue,
            from: currentSourceAccount!.name,
            to: currentDestinationAccount!.name)
        
        currentDestinationCell?.exchangeValueTextField.text = String(destinationValue)
    }
    
    
    //MARK: UICollectionViewDelegate and UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountsManager.accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cellRaw = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.identifier, for: indexPath)
        let cell = cellRaw as! CurrencyCollectionViewCell
        
        let account = accountsManager.accounts[indexPath.row]
        cell.currencyNameLabel.text = account.name
        cell.currentBalanceOfThisCurrencyLabel.text = "You have: \(account.value)"
        
        return cell
    }

    
    // реагирует на тап по карточке
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cvName : String
        if currencyCollectionView === collectionView {
            cvName = "coll_view_1"
        } else {
            cvName = "coll_view_2"
        }
        
        print("Collection View = \(cvName); Item selected == \(indexPath.row)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = currentPageIndex(scrollView)
        let indexPath = IndexPath(row: currentPage, section: 0)
        
        let sv1 = currencyCollectionView as UIScrollView
        let sv2 = currencyCollectionView2 as UIScrollView
        if sv1 === scrollView {
            currentSourceAccount = accountsManager.accounts[currentPage]
            currentSourceCell = cellByIndex(indexPath, currencyCollectionView)
        } else if sv2 === scrollView {
            currentDestinationAccount = accountsManager.accounts[currentPage]
            currentDestinationCell = cellByIndex(indexPath, currencyCollectionView2)
        }
    }
    
    func cellByIndex(_ index: IndexPath, _ collectionView: UICollectionView) -> CurrencyCollectionViewCell {
        return collectionView.cellForItem(at: index)! as! CurrencyCollectionViewCell
    }
    
    func currentPageIndex(_ scrollView: UIScrollView) -> Int {
        let layout = self.currencyCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        return Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    private var pageSize: CGSize {
        let layout = self.currencyCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
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

