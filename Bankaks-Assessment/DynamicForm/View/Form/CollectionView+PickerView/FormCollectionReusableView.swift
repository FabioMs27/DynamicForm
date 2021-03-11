//
//  FormCollectionReusableView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

/// Custom collection view header
class FormCollectionReusableView: UICollectionReusableView {
    //MARK:- Interface
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.04288191348, green: 0.476744771, blue: 0.2427864671, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    //MARK:- Constructor
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK:- View Code
extension FormCollectionReusableView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(headerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
