//
//  ServiceOptionView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

import SwiftUI

///Custom view with the service option interface
final class ServiceOptionView: UIView {
    private let dropDownDataSource = DropDownDataSource()
    private let options = (1...3).map { "Option \($0)" }
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.Device.width, height: Metrics.Device.height/2))
        view.backgroundColor = #colorLiteral(red: 0.4824108481, green: 0.7250191569, blue: 0.2658652067, alpha: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Welcome To"
        label.textColor = #colorLiteral(red: 0.06027474999, green: 0.4766826034, blue: 0.2427200377, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var optionTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.delegate = self
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(
            string: "Choose an option",
            attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle]
        )
        textField.attributedPlaceholder = attributedPlaceholder
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.inputView = optionPickerView
        return textField
    }()
    
    lazy var optionPickerView: UIPickerView = { [weak self] in
        let pickerView = UIPickerView()
        dropDownDataSource.update(values: options)
        pickerView.delegate = self
        pickerView.dataSource = dropDownDataSource
        return pickerView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.alpha = 0
        return label
    }()
    
    lazy var proccedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        return button
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
    
    func showInvalid(text: String) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            errorLabel.text = text
            errorLabel.alpha = 1
        }
        optionTextField.shakeAnimation()
    }
    
}
//MARK:- UITextFieldDelegate
extension ServiceOptionView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
//MARK:- UIPickerViewDelegate
extension ServiceOptionView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let optionNumber = options[row].components(separatedBy: " ").last else {
            return
        }
        optionTextField.text = optionNumber
        optionTextField.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dropDownDataSource.values[row]
    }
}

//MARK:- View Code
extension ServiceOptionView: ViewCodable {
    func setupHierarchyViews() {
        addSubview(backgroundView)
        addSubview(
            welcomeLabel,
            anchors: [.leading(layoutMargins.left), .trailing(0)]
        )
        backgroundView.addSubview(
            logoImageView,
            anchors: [.centerX(0), .centerY(0), .width(Metrics.Device.width * 0.8), .height(Metrics.Device.height * 0.8)]
        )
        addSubview(
            optionTextField,
            anchors: [.centerX(0), .centerY(0), .leading(layoutMargins.left), .trailing(-layoutMargins.right)]
        )
        addSubview(
            proccedButton,
            anchors: [.centerX(0), .leading(20 + layoutMargins.left), .trailing(-20 - layoutMargins.right)]
        )
        addSubview(
            errorLabel,
            anchors: [.centerX(0), .top(-16), .leading(0), .trailing(0)]
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -40),
            proccedButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

//MARK: - Preview
struct ServiceOptionViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ServiceOptionViewController(
                view: ServiceOptionView(),
                viewModel: ServiceOptionViewModel()
            )
        }
    }
}
