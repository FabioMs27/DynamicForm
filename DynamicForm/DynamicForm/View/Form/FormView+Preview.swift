//
//  FormView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit
import SwiftUI

final class FormView: UIView {
    var fieldStackViews = [FieldStackView]() {
        didSet {
            oldValue.forEach {
                formStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            fieldStackViews.forEach {
                formStackView.addArrangedSubview($0)
            }
        }
    }
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.4824108481, green: 0.7250191569, blue: 0.2658652067, alpha: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.04288191348, green: 0.476744771, blue: 0.2427864671, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var formStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment    = .fill
        stack.axis         = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var formScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK:- View Code
extension FormView: ViewCodable {
    func setupHierarchyViews() {
        addSubview(
            backgroundView,
            anchors: [.height(Metrics.Device.height/4), .width(Metrics.Device.width), .top(0)]
        )
        backgroundView.addSubview(
            headerLabel,
            anchors: [.centerX(0), .centerY(0)]
        )
        addSubview(
            formScrollView,
            anchors: [.leading(0), .trailing(0)]
        )
        
        formScrollView.addSubview(
            formStackView,
            anchors: [.top(16), .bottom(0)]
        )
        
        addSubview(
            submitButton,
            anchors: [.centerX(0), .leading(20 + layoutMargins.left), .trailing(-20 - layoutMargins.right)]
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            formScrollView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 2),
            formScrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            formStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

extension FormView {
    func buildFieldStackViews(_ fields: [Fields]) {
        fieldStackViews.removeAll()
        fieldStackViews = fields.map { field in
            buildFieldStackView(field)
        }
    }
    
    private func buildFieldStackView(_ field: Fields) -> FieldStackView {
        let stackView = FieldStackView(isMandatory: field.isMandatory, regex: field.regex)
        stackView.hintLabel.text = "hint: \(field.hintText)"
        stackView.inputTextField.attributedPlaceholder = field.placeholder.atributedString
        stackView.inputTextField.delegate = field.dataType.getTextFieldDelegate()
        stackView.inputTextField.keyboardType = field.dataType.getKeyboardType()
        if field.type == .dropdown {
            stackView.values = field.values
            stackView.inputTextField.inputView = stackView.optionPickerView
        }
        return stackView
    }
}

//MARK: - Preview
struct FormViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return FormViewController(
                formView: FormView(),
                viewModel: FormViewModel(option: 1)
            )
        }
    }
}
