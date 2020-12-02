//
//  ServiceOptionView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

final class ServiceOptionView: UIView{
    
    var options = [
        "1",
        "2",
        "3"
    ]
    
    lazy var optionTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: "Choose an option", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        textField.attributedPlaceholder = attributedPlaceholder
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.inputView = optionPickerView
        return textField
    }()
    
    lazy var optionPickerView: UIPickerView = { [weak self] in
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .clear
        return label
    }()
    
    lazy var proccedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension ServiceOptionView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension ServiceOptionView: UIPickerViewDelegate{}

extension ServiceOptionView: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Option " + options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        optionTextField.text = options[row]
        optionTextField.endEditing(true)
    }
    
}

extension ServiceOptionView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(optionTextField)
        addSubview(proccedButton)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            optionTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            optionTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            optionTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: proccedButton.topAnchor, constant: -16),
            errorLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            proccedButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            proccedButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16),
            proccedButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            proccedButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
