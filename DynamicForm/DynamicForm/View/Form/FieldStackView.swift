//
//  FieldStackView.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 19/05/21.
//

import UIKit

class FieldStackView: UIStackView {
    
    private let stackSpacing: CGFloat = 22
    let isMandatory: Bool
    let regex: String
    var text = String()
    
    private let dropDownDataSource = DropDownDataSource()
    var values: [String] {
        set {
            dropDownDataSource.update(values: newValue)
            optionPickerView.reloadAllComponents()
        }
        get { dropDownDataSource.values }
    }
    
    init(isMandatory: Bool, regex: String) {
        self.isMandatory = isMandatory
        self.regex = regex
        super.init(frame: .zero)
        addArrangedSubview(isMandatoryLabel)
        addArrangedSubview(inputTextField)
        addArrangedSubview(hintLabel)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        alignment    = .fill
        axis         = .vertical
        distribution = .fill
        spacing = stackSpacing
    }
    
    lazy var inputTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.addAction(
            UIAction { [weak self] action in
                if let textField = action.sender as? UITextField {
                    self?.text = textField.text ?? ""
                }
            }, for: .editingDidEnd
        )
        return textField
    }()
    
    lazy var optionPickerView: UIPickerView = { [weak self] in
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = dropDownDataSource
        return pickerView
    }()
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.06027474999, green: 0.4766826034, blue: 0.2427200377, alpha: 1)
        return label
    }()
    
    lazy var isMandatoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "*"
        label.textColor = .systemRed
        label.alpha = 0
        return label
    }()
    
    func showInvalid(text: String) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            isMandatoryLabel.text = text
            isMandatoryLabel.alpha = 1
        }
        inputTextField.shakeAnimation()
    }
}

//MARK:- UIPickerViewDelegate
extension FieldStackView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = values[row]
        inputTextField.text = text
        inputTextField.endEditing(true)
    }
}
