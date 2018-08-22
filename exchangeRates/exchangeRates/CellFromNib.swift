//
//  CellFromNib.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import UIKit

protocol CellFromNib {

    static var reuseIdentifier: String { get }
    static var nib: UINib { get }

}

extension CellFromNib where Self: UITableViewCell {

    static var reuseIdentifier: String {
        return className + ".reuseId"
    }

    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }

    private static var className: String {
        return "\(self)"
    }
}
