//
//  NibInitializable.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit

protocol NibInitializable {
    static var nibIdentifier: String { get }
}

extension NibInitializable where Self: UIViewController {

    static var nibIdentifier: String {
        return String(describing: Self.self)
    }

    static func instanceFromNib() -> Self {
        return UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! Self
    }
}
