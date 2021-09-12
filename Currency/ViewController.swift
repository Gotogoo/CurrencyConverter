//
//  ViewController.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var sourceTextField: UITextField!
  @IBOutlet weak var targetTextField: UITextField!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var outputTextField: UITextField!
  @IBOutlet weak var exchangeRateTextField: UITextField!
  @IBOutlet weak var updateExchangeRateButton: UIButton!
  @IBOutlet weak var exchangeRatesTextView: UITextView!

  private let picker = UIPickerView()
  private let toolBar = UIToolbar()

  private let dataSource: [[Currency]] = [
    [CryptoCurrency.btc, CryptoCurrency.eth],
    [LegalCurrency.usd, LegalCurrency.rmb],
  ]

  private var exchangeRateTable = ExchangeRateTable()

  private var converter: CurrencyConverter {
    CurrencyConverter(exchangeRateTable)
  }

  var pair: CurrencyPair? {
    guard let source = CryptoCurrency.from(code: sourceTextField.text ?? ""),
      let target = LegalCurrency.from(code: targetTextField.text ?? "") else {
        return nil
    }
    return CurrencyPair(source: source, target: target)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpUI()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }

  private func setUpUI() {
    picker.delegate = self
    picker.dataSource = self

    sourceTextField.inputView = picker
    targetTextField.inputView = picker

    sourceTextField.inputAccessoryView = toolBar
    targetTextField.inputAccessoryView = toolBar

    inputTextField.delegate = self
    inputTextField.keyboardType = .decimalPad
    outputTextField.isUserInteractionEnabled = false

    exchangeRatesTextView.isEditable = false
    setRatesDescription()

    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = .systemBlue
    toolBar.sizeToFit()
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(pressDone))
    toolBar.setItems([spaceButton, doneButton], animated: false)
  }

  @objc private func pressDone() {
    (0..<dataSource.count).forEach { component in
      pickerView(picker, didSelectRow: picker.selectedRow(inComponent: component), inComponent: component)
    }
    inputTextField.becomeFirstResponder()
  }


  @IBAction func pressUpdateExchangeRate(_ sender: Any) {
    guard let exchangeRateString = exchangeRateTextField.text,
      let exchangeRate = Double(exchangeRateString),
      let pair = pair else {
      return
    }
    exchangeRateTable.set(exchangeRate: exchangeRate, for: pair)
    setRatesDescription()
  }

  private func setRatesDescription() {
    exchangeRatesTextView.text = exchangeRateTable.ratesDescription()
  }

  private func setExchangeRate() {
    guard let pair = pair,
      let rate = exchangeRateTable.get(for: pair) else {
      exchangeRateTextField.text = nil
      return
    }
    exchangeRateTextField.text = "\(rate)"
  }

  private func calculate() {
    guard let pair = pair,
      let amount = Double(inputTextField.text ?? ""),
      let outpunt = converter.convert(amount, from: pair.source, to: pair.target) else {
      outputTextField.text = nil
      return
    }

    outputTextField.text = "\(outpunt)"
  }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return dataSource.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return dataSource[component].count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return dataSource[component][row].code
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let textField = component == 0 ? sourceTextField : targetTextField
    textField?.text = dataSource[component][row].code
    setExchangeRate()
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    calculate()
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
