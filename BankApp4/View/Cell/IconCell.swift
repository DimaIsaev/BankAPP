//
//  IconCell.swift
//  BankApp4
//
//  Created by Дмитрий Исаев on 19.07.2024.
//

import UIKit

class IconCell: UICollectionViewCell {
    
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.layer.opacity = 0.32
        return imageView
    }()
    
    func setIcon(image: UIImage) {
        imageView.image = image
        self.addSubview(imageView)
        self.addSubview(checkImage)
        
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            
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
