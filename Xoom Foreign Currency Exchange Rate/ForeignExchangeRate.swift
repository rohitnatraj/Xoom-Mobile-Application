//
//  ForeignExchangeRate.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/19/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import Foundation
import UIKit

class ForeignExchangeRate: UITableViewController, UIDataSourceModelAssociation {
        
        @IBOutlet var currencyCodeLabel: UILabel!
        @IBOutlet var foreignExchangeRateLabel: UILabel!
        @IBOutlet var countryCodeLabel: UILabel!
        @IBOutlet var feesChangeLabel: UILabel!
        lazy var service: XoomForeignExchangeRateService = {
                return XoomForeignExchangeRateService()
        }()
        
        var currencyCode = ""
        var foreignExchangeRate = Double()
        var countryCode = ""
        var feesChanged = ""
        
        override func viewDidLoad() {
                super.viewDidLoad()
                self.navigationItem.title = "Foreign Exchange Rates"
                tableView.tableFooterView = UIView()
                tableView.separatorColor = UIColor.clear
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.storeDataInUserDefaults()
        }
        
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                
                self.currencyCodeLabel.text = self.currencyCode
                self.foreignExchangeRateLabel.text = String(self.foreignExchangeRate)
                self.countryCodeLabel.text = self.countryCode
                self.feesChangeLabel.text = self.feesChanged
        }
        
        func storeDataInUserDefaults() {
                UserDefaults.standard.setValue(self.currencyCode, forKey: "CurrencyCode")
                UserDefaults.standard.setValue(self.foreignExchangeRate, forKey: "ForeignExchangeRate")
                UserDefaults.standard.setValue(self.countryCode, forKey: "CountryCode")
                UserDefaults.standard.setValue(self.feesChanged, forKey: "FeesChanged")
                UserDefaults.standard.synchronize()
        }
        
        func showOnNavigationController(navigationController:UINavigationController) {
                navigationController.pushViewController(self, animated: false)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
                return 4
        }
        
        //MARK:- Attempt to persist the user last seen country
        
        override func encodeRestorableState(with coder: NSCoder) {
                super.encode(with: coder)
                coder.encode(self.currencyCode)
                coder.encode(self.foreignExchangeRate)
                coder.encode(self.countryCode)
                coder.encode(self.feesChanged)
        }
        
        override func decodeRestorableState(with coder: NSCoder) {
                super.decodeRestorableState(with: coder)
                coder.decodeObject()
        }
        
        func modelIdentifierForElement(at idx: IndexPath, in view: UIView) -> String? {
                var currencyCode = ""
                if !idx.isEmpty {
                         currencyCode = self.currencyCode
                }
                return currencyCode
        }
        
        func indexPathForElement(withModelIdentifier identifier: String, in view: UIView) -> IndexPath? {
                let indexPath = NSIndexPath(row: 0, section: 0)
                return indexPath as IndexPath
        }
        
       
}
