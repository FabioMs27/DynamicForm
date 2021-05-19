//
//  FormViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit
/// Class containing the form Interface
class FormViewController: UIViewController {
    
    private let formView: FormView
    private let formViewModel: FormViewModel
    
    init(formView: FormView, viewModel: FormViewModel) {
        self.formView = formView
        self.formViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = formView
    }
    
    private func setup() {
        bindViewModel()
        fetchForm()
        hideKeyboardWhenTappedAround()
        formView.submitButton.addAction(UIAction(handler: submitForm),for: .touchUpInside)
    }
    
    /// Method called when submit button is pressed. It validates all fields and update accordingly.
    /// - Parameter sender: The button that was pressed.
    func submitForm(sender: UIAction){
        var isValid = true
        formView.fieldStackViews
            .filter { $0.isMandatory }
            .forEach { fieldStack in
                do {
                    try formViewModel.validateInputs(
                        value: fieldStack.inputTextField.text,
                        pattern: fieldStack.regex
                    )
                    fieldStack.isMandatoryLabel.textColor = .clear
                } catch {
                    fieldStack.showInvalid(text: error.localizedDescription)
                    isValid = false
                }
            }
        isValid ? completeAssessment() : giveInvalidFeedback()
    }
    
    private func completeAssessment() {
        UIView.animate(withDuration: 1) { [unowned self] in
            formView.submitButton.backgroundColor = .green
            formView.submitButton.setImage(.checkmark, for: .normal)
        }
        showOkAlert(title: "You have completed the Assessment")
    }
    
    /// Method that fetchs from api and uptade view accordingly. It sets up a loading screen while fetching data.
    func fetchForm() {
        hideActivityIndicator()
        showActivityIndicator()
        formViewModel.fetchForm()
    }
    
    func bindViewModel() {
        formViewModel.errorPublisher.bind { [weak self] error in
            self?.hideActivityIndicator()
            self?.showAlert(title: error?.localizedDescription)
        }
        
        formViewModel.formPublisher.bind { [weak self] form in
            guard let self = self else { return }
            self.hideActivityIndicator()
            self.formView.buildFieldStackViews(form?.fields ?? [])
            self.formView.headerLabel.text = form?.screenTitle
        }
    }
    
    /// Method that presents an alert. It has two options and goes back to the previous screen.
    /// - Parameter title: A string to be presented on the alert view.
    func showAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.fetchForm()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(tryAgainAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
