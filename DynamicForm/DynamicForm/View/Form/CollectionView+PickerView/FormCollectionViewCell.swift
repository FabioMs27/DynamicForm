//
//  FormCollectionViewCell.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

/// Enum with the states of the textField.
enum InputState {
    case filled
    case notFilled
    case optional
}

/// Custom collectionViewCell with the inputs.
class FormCollectionViewCell: UICollectionViewCell {
    //MARK:- Atributtes
    var isMandatory: Bool = false
    var regex: String = ""
    //MARK:- Interface
    lazy var inputTextField: UITextField = { [weak self] in
        let textField = UITextField()
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
    //MARK:- Constructor
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutMargins.left = 20
        layoutMargins.right = 20
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
//MARK:- UITextFieldDelegate
extension FormCollectionViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- UIPickerViewDelegate
extension FormCollectionViewCell: UIPickerViewDelegate{}
//MARK:- UIPickerViewDataSource
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
//MARK:- View Code
extension FormCollectionViewCell: ViewCodable {
    func setupHierarchyViews() {
        let margins:[LayoutAnchor] = [.leading(layoutMargins.left), .trailing(-layoutMargins.right)]
        addSubview(inputTextField, anchors: margins)
        addSubview(hintLabel, anchors: margins)
        addSubview(isMandatoryLabel, anchors: margins)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            isMandatoryLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            inputTextField.topAnchor.constraint(equalTo: isMandatoryLabel.bottomAnchor, constant: 8),
            hintLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 8),
        ])
    }
}
