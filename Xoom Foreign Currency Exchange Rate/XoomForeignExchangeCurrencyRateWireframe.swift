//
//  XoomForeignExchangeCurrencyRateWireframe.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/18/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit

class XoomForeignExchangeCurrencyRateWireframe : NSObject, XoomForeignExchangeCurrencyRatePresenterToWireframeInterface {
        
        // MARK: - VIPER Stack
        lazy var moduleInteractor = XoomForeignExchangeCurrencyRateInteractor()
        // Uncomment the comment lines and delete the moduleView line default code to use a navigationController from storyboard
        
        lazy var moduleNavigationController: UINavigationController = {
                let sb = XoomForeignExchangeCurrencyRateWireframe.storyboard()
                let v = sb.instantiateViewController(withIdentifier: kXoomForeignExchangeCurrencyRateNavigationControllerIdentifier) as! UINavigationController
                return v
        }()
        
        lazy var modulePresenter = XoomForeignExchangeCurrencyRatePresenter()
        
        lazy var moduleView: XoomForeignExchangeCurrencyRateView = {
                return self.moduleNavigationController.viewControllers[0] as! XoomForeignExchangeCurrencyRateView
        }()
        
        lazy var presenter : XoomForeignExchangeCurrencyRateWireframeToPresenterInterface = self.modulePresenter

        // MARK: - Instance Variables
        var delegate: XoomForeignExchangeCurrencyRateDelegate?
        
        // MARK: - Initialization
        override init() {
                super.init()
                
                let i = moduleInteractor
                let p = modulePresenter
                let v = moduleView
                
                i.presenter = p
                
                p.interactor = i
                p.view = v
                p.wireframe = self
                
                v.presenter = p
                
                presenter = p
                
        }

	class func storyboard() -> UIStoryboard {
                return UIStoryboard(name: "Main", bundle: Bundle.main)
	}
        
        // MARK: - Operational
        func presentingListOfCountries() {
                presenter.presentingListOfCountries()
        }
        
        
        
        
}
