//
//  ViewController.swift
//  BankApp4
//
//  Created by Дмитрий Исаев on 19.07.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#141414FF")
        
        builder.setPageTitle(titleText: "Design your virtual card")
        builder.getCard()
        builder.getColorSlide()
        builder.getImageSlide()
        builder.setDescriptionText()
        builder.addButton()
    }


}

