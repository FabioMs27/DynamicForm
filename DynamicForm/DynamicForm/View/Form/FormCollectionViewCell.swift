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
    var isMandatory: Bool = false
    var regex: String = ""
    private let dropDownDataSource = DropDownDataSource()
    var values: [String] {
        set {
            dropDownDataSource.update(values: newValue)
            optionPickerView.reloadAllComponents()
        }
        get { dropDownDataSource.values }
    }
    
    lazy var inputTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
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
    //MARK:- Constructor
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showInvalid(text: String) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            isMandatoryLabel.text = text
            isMandatoryLabel.alpha = 1
        }
        inputTextField.shakeAnimation()
    }
    
}
//MARK:- UITextFieldDelegate
extension FormCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- UIPickerViewDelegate
extension FormCollectionViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = values[row]
        inputTextField.text = text
        inputTextField.endEditing(true)
    }
}

//MARK:- View Code
extension FormCollectionViewCell: ViewCodable {
    func setupHierarchyViews() {
        let margins:[LayoutAnchor] = [.leading(layoutMargins.left), .trailing(-layoutMargins.right)]
        addSubview(inputTextField, anchors: margins)
        addSubview(hintLabel, anchors: margins + [.bottom(0)])
        addSubview(isMandatoryLabel, anchors: margins)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            isMandatoryLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            inputTextField.topAnchor.constraint(equalTo: isMandatoryLabel.bottomAnchor, constant: 8),
            hintLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 8),
        ])
    }
    
    func setupAdditionalConfiguration() {
        layoutMargins = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20
        )
    }
}