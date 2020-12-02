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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FormCollectionViewCell ?? FormCollectionViewCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? FormCollectionReusableView ?? FormCollectionReusableView()
        
        header.headerLabel.text = "Deu bom demais"
        return header
    }
}
