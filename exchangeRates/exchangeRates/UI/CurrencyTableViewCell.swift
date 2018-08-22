//
//  CurrencyTableViewCell.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    var onEdit: ((String)->Void)?
    var defaultValue: Float = 0

    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var valueTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onEdit = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction fileprivate func valueEditingChanged(_ sender: Any) {

        guard let value = valueTextField.text else {
            valueTextField.text = String(defaultValue)
            return
        }

        print(value)
        onEdit?(value)
    }
}

extension CurrencyTableViewCell: CellFromNib {}
