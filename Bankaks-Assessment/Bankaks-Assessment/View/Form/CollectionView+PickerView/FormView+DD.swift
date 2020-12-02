//
//  FormCollectionView+DD.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

enum DataTypes: String {
    case int
    case string
}

enum Ui_Types: String {
    case dropdown
    case textfield
}

extension FormView: UICollectionViewDelegate{}

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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        guard
            let header = collectionReusableView as? FormCollectionReusableView,
            let result = self.result else { return collectionReusableView }
        
        header.headerLabel.text = result.screen_title
        return header
    }
    
    func setUpCell(_ cell: inout FormCollectionViewCell, field: Field){
        cell.hintLabel.text = field.hint_text
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: field.placeholder, attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        cell.inputTextField.attributedPlaceholder = attributedPlaceholder
        
        cell.regex = field.regex
        
        switch DataTypes(rawValue: field.type.data_type) {
        case .int:
            cell.inputTextField.delegate = self
        case .string: break
        case .none: break
        }
        
        cell.isMandatory = Bool(from:field.is_mandatory)
        
        switch Ui_Types(rawValue: field.ui_type.type) {
        case .dropdown:
            cell.optionPickerView.values = field.ui_type.values.map{ value in (name: value.name, id: value.id) }
            cell.inputTextField.inputView = cell.optionPickerView
        case .textfield: break
        case .none: break
        }
    }
}

extension FormView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension Bool {
    init(from: String) {
        self = (from as NSString).boolValue
    }
}
