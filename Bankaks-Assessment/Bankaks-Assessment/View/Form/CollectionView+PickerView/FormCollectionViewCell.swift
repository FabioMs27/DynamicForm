//
//  FormCollectionViewCell.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

enum InputState {
    case filled
    case notFilled
    case optional
}

class FormCollectionViewCell: UICollectionViewCell {
    
    var isMandatory: Bool = false
    var regex: String = ""
    
    lazy var inputTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var optionPickerView: FormPickerView = { [weak self] in
        let pickerView = FormPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.06027474999, green: 0.4766826034, blue: 0.2427200377, alpha: 1)
        return label
    }()
    
    lazy var isMandatoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "*"
        label.textColor = .systemRed
        label.alpha = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension FormCollectionViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension FormCollectionViewCell: UIPickerViewDelegate{}

extension FormCollectionViewCell: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let customPickerView = pickerView as? FormPickerView else { return 0 }
        return customPickerView.values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let customPickerView = pickerView as? FormPickerView else { return "" }
        return customPickerView.values[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let customPickerView = pickerView as? FormPickerView else { return }
        let text = customPickerView.values[row].name
        inputTextField.text = text
        inputTextField.endEditing(true)
    }
    
}

extension FormCollectionViewCell: ViewCodable {
    func setupHierarchyViews() {
        addSubview(inputTextField)
        addSubview(hintLabel)
        addSubview(isMandatoryLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            isMandatoryLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            isMandatoryLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            isMandatoryLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
            
            inputTextField.topAnchor.constraint(equalTo: isMandatoryLabel.bottomAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
            
            hintLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 8),
            hintLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            hintLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
        ])
    }
    
    func setupAdditionalConfiguration() {}
}
