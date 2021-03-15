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
    var values = [String]()
    //MARK:- Interface
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
extension FormCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- UIPickerViewDelegate
extension FormCollectionViewCell: UIPickerViewDelegate { }
//MARK:- UIPickerViewDataSource
extension FormCollectionViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
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
}
