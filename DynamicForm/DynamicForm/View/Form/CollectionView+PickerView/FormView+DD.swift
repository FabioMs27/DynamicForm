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
extension FormView: UICollectionViewDelegate{ }
//MARK:- UICollectionViewDataSource
extension FormView: UICollectionViewDataSource{
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
    func setUpCell(_ cell: inout FormCollectionViewCell, field: Field){
        //Hint
        cell.hintLabel.text = "hint: \(field.hint_text)"
        //Place holder
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: field.placeholder, attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        cell.inputTextField.attributedPlaceholder = attributedPlaceholder
        //Regex
        cell.regex = field.regex
        //Data Type
        switch DataTypes(rawValue: field.type.data_type) {
        case .int:
            cell.inputTextField.delegate = self
        case .string: break
        case .none: break
        }
        //Is mandatory
        cell.isMandatory = Bool(from:field.is_mandatory)
        //UI Type
        switch Ui_Types(rawValue: field.ui_type.type) {
        case .dropdown:
            cell.optionPickerView.values = field.ui_type.values.map{ value in (name: value.name, id: value.id) }
            cell.inputTextField.inputView = cell.optionPickerView
        case .textfield: break
        case .none: break
        }
    }
}
//MARK:- UITextFieldDelegate
extension FormView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- Bool
extension Bool {
    init(from: String) {
        self = (from as NSString).boolValue
    }
}
