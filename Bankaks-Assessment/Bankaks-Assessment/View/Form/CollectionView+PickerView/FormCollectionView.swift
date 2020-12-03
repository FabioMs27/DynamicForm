//
//  FormCollectionView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

/// Custom collection view used to create the dynamic forms.
class FormCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension FormCollectionView: ViewCodable{
    func setupHierarchyViews() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
