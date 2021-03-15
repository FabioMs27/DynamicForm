//
//  FormCollectionView+DD.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

/// Enum containing possible data types from api
enum DataTypes: String {
    case int
    case string
}
/// Enum containing the possible ui_types from api
enum Ui_Types: String {
    case dropdown
    case textfield
}
//MARK:- UICollectionViewDelegate
extension FormView: UICollectionViewDelegate { }
//MARK:- UICollectionViewDataSource
extension FormView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FormCollectionViewCell ?? FormCollectionViewCell()
        let field = fields[indexPath.item]
        
        setUpCell(&cell, field: field)
        
        return cell
    }
    
    /// Method that sets up cells according to the model.
    /// - Parameters:
    ///   - cell: The custom cell with the textFields.
    ///   - field: The model containing info about the cell.
    func setUpCell(_ cell: inout FormCollectionViewCell, field: Fields) {
        //Hint
        cell.hintLabel.text = "hint: \(field.hintText)"
        //Place holder
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: field.placeholder, attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        cell.inputTextField.attributedPlaceholder = attributedPlaceholder
        //Regex
        cell.regex = field.regex
        //Data Type
        if field.dataType == .int {
            cell.inputTextField.delegate = self
        }
        //Is mandatory
        cell.isMandatory = field.isMandatory
        //UI Type
        if field.type == .dropDown {
            cell.values = field.values
            cell.inputTextField.inputView = cell.optionPickerView
        }
    }
}
//MARK:- UITextFieldDelegate
extension FormView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
