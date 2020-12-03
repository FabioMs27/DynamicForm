//
//  FormCollectionView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

class FormCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showHints(){
        for cell in visibleCells{
            guard let cell = cell as? FormCollectionViewCell else { return }
            cell.isMandatoryLabel.text = "*"
            cell.isMandatoryLabel.textColor = .systemRed
            cell.hintLabel.textColor = .black
        }
    }

}

extension FormCollectionView: ViewCodable{
    func setupHierarchyViews() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
