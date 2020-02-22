//
//  Util.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import NVActivityIndicatorView

class Utility {
    static func startIndicatorAnimation() {
        DispatchQueue.main.async {
            let activityData = ActivityData(type: .ballPulse,
                                            color: #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1),
                                            backgroundColor : UIColor.black.withAlphaComponent(0.1))
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }
    }
    
    static func stopIndicatorAnimation() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    static func ignoreNil<A>(x: A?) -> Observable<A> {
      return x.map { Observable.just($0) } ?? Observable.empty()
    }

}
