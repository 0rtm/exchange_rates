//
//  RatesViewController.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

class Section {
    var rates: [CurrencyRate] = []
}

class RatesViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!

    fileprivate var sections: [Section] = []

    fileprivate var multiplier: Float = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        test()
    }

    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
    }

    fileprivate func test() {

        let url = URL(string: "https://revolut.duckdns.org")!
        let api = APIService(serverURL: url)
        api.fetchRates(for: "EUR") { [weak self] (error, rates) in
            print("\(rates) \(error)")

                guard let _rates = rates else {
                    return
                }


            let baseSection = Section()
            baseSection.rates = [_rates.baseRate]

            let section = Section()
            section.rates = _rates._rates

            self?.sections = [baseSection, section]
            self?.tableView.reloadData()

        }
    }

}

extension RatesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            return
        }

        //changeBaseRate(to: )

    }
}

extension RatesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell else {
            fatalError("Table view must have cells")
        }

        let rate = sections[indexPath.section].rates[indexPath.row]
        cell.currencySymbolLabel.text = rate.name
        cell.valueTextField.text = String(rate.value*multiplier)

       // if indexPath.row == 0 {
            cell.onEdit = { [weak self] newValue in

                if (indexPath.section) != 0 {
                    //animate to top

                    let prevRate = self?.sections[0].rates[0]
                    self?.sections[0].rates = [rate]
                    self?.sections[indexPath.section].rates[indexPath.row] = prevRate!

                    tableView.beginUpdates()
                    let baseCellRow =  IndexPath(row: 0, section: 0)
                    tableView.moveRow(at: indexPath, to: baseCellRow)
                    tableView.moveRow(at: baseCellRow, to: indexPath)
                    tableView.endUpdates()
                    tableView.reloadRows(at: [baseCellRow], with: .none)
                }

                self?.multiplier =  Float(newValue) ?? 0

                self?.updateVisibleCells()
            }

        return cell
    }

    func updateVisibleCells() {
        for cell in tableView.visibleCells {

            guard let indexPath = tableView.indexPath(for: cell) else {
                continue
            }

            if indexPath.section == 0 {
                continue
            }

            guard let _cell = cell as? CurrencyTableViewCell else {
                continue
            }

            let rate = sections[indexPath.section].rates[indexPath.row]

            _cell.valueTextField.text = String(rate.value*multiplier)

        }
    }

}
