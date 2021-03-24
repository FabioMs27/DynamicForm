//
//  UIViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

extension UIViewController {
    fileprivate var tag: Int { 9999 }
    
    /// Presents a loading screen on top of the view controller.
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let spinnerView = UIView(frame: .zero)
            spinnerView.translatesAutoresizingMaskIntoConstraints = false
            spinnerView.tag = self.tag
            spinnerView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            spinner.color = .white
            
            spinnerView.addSubview(spinner)
            self.view.addSubview(spinnerView)
            
            NSLayoutConstraint.activate([
                spinnerView.topAnchor.constraint(equalTo: self.view.topAnchor),
                spinnerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                spinnerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                spinnerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                
                spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        }
    }
    
    /// Remove the loading screen from the main view.
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            for view in self.view.subviews {
                if view.tag == self.tag {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func giveInvalidFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    /// Method that presents an alert. It has an ok option to continue the app.
    /// - Parameter title: A string to be presented on the alert view.
    func showOkAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
