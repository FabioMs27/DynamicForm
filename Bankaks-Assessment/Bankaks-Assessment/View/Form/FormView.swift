//
//  FormView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

class FormView: UIView{
    
    var screen: CGSize{
        UIScreen.main.bounds.size
    }
    
    lazy var collectionView: FormCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 170)
        layout.headerReferenceSize = CGSize(width: screen.width, height: 80)
        let collectionView = FormCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FormCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(FormCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .clear
        return label
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FormView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(collectionView)
        addSubview(errorLabel)
        addSubview(submitButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: errorLabel.topAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            errorLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16),
            submitButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
