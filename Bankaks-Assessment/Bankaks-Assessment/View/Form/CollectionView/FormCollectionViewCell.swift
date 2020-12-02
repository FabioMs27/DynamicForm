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
    
    lazy var inputTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var optionPickerView: UIPickerView = { [weak self] in
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .clear
        return label
    }()
    
    lazy var isMandatoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .clear
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
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
            isMandatoryLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            isMandatoryLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            isMandatoryLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            inputTextField.topAnchor.constraint(equalTo: isMandatoryLabel.bottomAnchor, constant: -2),
            inputTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            hintLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: -2),
            hintLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            hintLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {}
}
