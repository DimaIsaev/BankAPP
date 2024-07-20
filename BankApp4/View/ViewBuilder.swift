//
//  ViewBuilder.swift
//  BankApp4
//
//  Created by Дмитрий Исаев on 19.07.2024.
//

import UIKit

final class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    private var card = UIView()
    private let balance: Float = 9.999
    private let cardNumber: Int = 1234
    
    private var colorCollection: UICollectionView!
    private var imageCollection: UICollectionView!
    
    var controller: UIViewController
    var view: UIView
    
    var cardColor: [String] = ["#16A085FF","#003F32FF"] {
        willSet {
            if let colorView = view.viewWithTag(7) {
                colorView.layer.sublayers?.remove(at: 0)
                let gradient = manager.getGradient(colors: newValue)
                colorView.layer.sublayers?.insert(gradient, at: 0)
            }
            
        }
    }
    
    var cardImage: UIImage = .icon1 {
        willSet {
            if let imageView = view.viewWithTag(8) as? UIImageView {
                imageView.image = newValue
            }
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    private lazy var pageTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setPageTitle(titleText: String) {
        pageTitle.text = titleText
        
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func getCard() {
        card = manager.getCard(cardColor: cardColor, cardImage: cardImage, cardBalance: balance, cardNumber: cardNumber)
        
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        ])
    }
    
    func getColorSlide() {
        let colorTitle = manager.setSlideTitle(textTitle: "Select color")
        
        colorCollection = manager.getCollection(id: "colors", dataSource: self, delegate: self)
        colorCollection.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colorTitle)
        view.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
            colorTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 60),
            colorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 23),
            colorCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getImageSlide() {
        let imageTitle = manager.setSlideTitle(textTitle: "Add shapes")
        
        imageCollection = manager.getCollection(id: "icons", dataSource: self, delegate: self)
        imageCollection.register(IconCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(imageTitle)
        view.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            imageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageTitle.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 50),
            
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollection.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 23)
        ])
    }
    
    func setDescriptionText() {
        let descrText: UILabel = {
            let descrText = UILabel()
            descrText.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
            descrText.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            descrText.textColor = UIColor(hex: "#6F6F6FFF")
            descrText.numberOfLines = 0
            descrText.setLineHeight(lineHeight: 10)
            descrText.translatesAutoresizingMaskIntoConstraints = false
            return descrText
        }()
        
        view.addSubview(descrText)
        
        NSLayoutConstraint.activate([
            descrText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descrText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descrText.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 42)
        ])
    }
    
    func addButton() {
        let button = {
            let btn = UIButton()
            btn.setTitle("Continue", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            btn.backgroundColor = .white
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.widthAnchor.constraint(equalToConstant: 370).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
            btn.layer.cornerRadius = 20
            btn.layer.shadowColor = UIColor.white.cgColor
            btn.layer.shadowRadius = 10
            btn.layer.shadowOpacity = 0.25
            return btn
        }()
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension ViewBuilder: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case "colors":
            return manager.colors.count
        case "icons":
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case "colors":
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
                let color = manager.colors[indexPath.item]
                cell.setCell(color: color)
                return cell
            }
        case "icons":
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCell {
                let image = manager.images[indexPath.item]
                cell.setIcon(image: image)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case "colors":
            let color = manager.colors[indexPath.item]
            cardColor = color
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
        case "icons":
            let image = manager.images[indexPath.item]
            cardImage = image
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case "colors":
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.deselectItem()
        case "icons":
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
    }
}
