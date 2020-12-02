//
//  FormCollectionView+DD.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

extension FormView: UICollectionViewDelegate{}

extension FormView: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FormCollectionViewCell ?? FormCollectionViewCell()
        let field = fields[indexPath.item]
        
        cell.hintLabel.text = field.hint_text
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: field.placeholder, attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        cell.inputTextField.attributedPlaceholder = attributedPlaceholder
        
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
}
