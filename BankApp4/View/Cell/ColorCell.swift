//
//  ColorCell.swift
//  BankApp4
//
//  Created by Дмитрий Исаев on 19.07.2024.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    private lazy var checkImage: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark")
        checkImage.tintColor = .white
        checkImage.translatesAutoresizingMaskIntoConstraints = false
        checkImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkImage.isHidden = true
        return checkImage
    }()
    
    func setCell(color: [String]) {
        let gradien = ViewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: color)
        self.layer.addSublayer(gradien)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
            checkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func selectItem() {
        checkImage.isHidden = false
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
}
