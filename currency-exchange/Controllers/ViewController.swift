//
//  ViewController.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 05/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var sourceCollectionView: UICollectionView!
    @IBOutlet weak var destinationCollectionView: UICollectionView!
    
    private let accountsManager = AccountsManager()
    
    private lazy var currentSourceAccount = accountsManager.accounts[0]
    private lazy var currentDestinationAccount = accountsManager.accounts[0]
    private var amount = 0.0
    
    private var currentSourceCell : CurrencyCollectionViewCell?
    private var currentDestinationCell : CurrencyCollectionViewCell?
    
    private let converter = Converter()
    private let transactionManager = TransactionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setup(collectionView: sourceCollectionView)
        setup(collectionView: destinationCollectionView)
        
        currentSourceAccount = accountsManager.accounts[0]
        currentDestinationAccount = accountsManager.accounts[0]
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
        let transaction = Transaction(
                sourceAccount: currentSourceAccount,
                destinationAccount: currentDestinationAccount,
                amount: amount)
        
        do {
            try transactionManager.doTransaction(transaction)
            reloadCollectionData()
            let transactionAmount = converter.rate(value: transaction.amount, from: transaction.sourceAccount.currencyName, to: transaction.destinationAccount.currencyName)
            showAllert(amount: transactionAmount, destinationAccount: transaction.destinationAccount)
        } catch TransactionError.insufficientFunds {
            showErrorAlert(message: "Insufficient Funds")
        } catch {
            showErrorAlert(message: "Unexpected error")
        }
        
    }
    
    func reloadCollectionData(){
        self.sourceCollectionView.reloadData()
        self.destinationCollectionView.reloadData()
    }
    
    @IBAction func sourceTransactionValueChanged(_ sender: UITextField) {
        let sourceValueText = sender.text
        guard let sourceValue = Double(sourceValueText!) else {
            currentDestinationCell?.exchangeValueTextField.text = nil
            return
        }
        amount = sourceValue
        
        let destinationValue = converter.rate(
            value: sourceValue,
            from: currentSourceAccount.currencyName,
            to: currentDestinationAccount.currencyName)
        
        currentDestinationCell?.exchangeValueTextField.text = String(destinationValue)
    }
    
    
    //MARK: UICollectionViewDelegate and UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountsManager.accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.identifier, for: indexPath) as! CurrencyCollectionViewCell
        
        let account = accountsManager.accounts[indexPath.row]
        let currencyName = account.currencyName
        cell.currencyNameLabel.text = "\(currencyName.rawValue)"
        cell.currentBalanceOfThisCurrencyLabel.text = "You have: \(account.value)\(currencyName.sign())"
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = currentPageIndex(scrollView)
        let indexPath = IndexPath(row: currentPage, section: 0)
        
        let sv1 = sourceCollectionView as UIScrollView
        let sv2 = destinationCollectionView as UIScrollView
        if sv1 === scrollView {
            currentSourceAccount = accountsManager.accounts[currentPage]
            currentSourceCell = cellByIndex(indexPath, sourceCollectionView)
        } else if sv2 === scrollView {
            currentDestinationAccount = accountsManager.accounts[currentPage]
            currentDestinationCell = cellByIndex(indexPath, destinationCollectionView)
        }
        
        let rate = converter.rate(
            value: 1,
            from: currentSourceAccount.currencyName,
            to: currentDestinationAccount.currencyName)
        self.navigationItem.title = "\(currentSourceAccount.currencyName.sign())1 = \(currentDestinationAccount.currencyName.sign())\(rate)"
    }
    
    func cellByIndex(_ index: IndexPath, _ collectionView: UICollectionView) -> CurrencyCollectionViewCell {
        return collectionView.cellForItem(at: index)! as! CurrencyCollectionViewCell
    }
    
    func currentPageIndex(_ scrollView: UIScrollView) -> Int {
        let layout = self.sourceCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        return Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    private var pageSize: CGSize {
        let layout = self.sourceCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    private func showAllert(amount: Double, destinationAccount: Account){
        let title =
            "Reciept \(amount) to account \(destinationAccount.currencyName.rawValue). Available balance: \(destinationAccount.currencyName.sign())\(destinationAccount.value)"
        
        var message = "Available accounts:\n"
        for account in accountsManager.accounts {
            message += "\(account.currencyName.rawValue) : \(account.currencyName.sign())\(account.value)\n"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
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


extension Error {
    func printDescription() {
        print(self)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
