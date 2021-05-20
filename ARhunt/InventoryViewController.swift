//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController{
    let testArray = [3,4,3,4,3,2,4,5]

    override func viewDidLoad(){
        super.viewDidLoad()
        let totalItems = testArray.count
        let totalRows = ceil(Float(totalItems)/4)
        let itemCountInLastRow = totalItems % 4
        
        let inventoryScrollView = UIScrollView()
        self.view.addSubview(inventoryScrollView)
        let fullStackView = UIStackView()
        
        //inventoryScrollView
        inventoryScrollView.showsHorizontalScrollIndicator = false
        inventoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        inventoryScrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            inventoryScrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            inventoryScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            inventoryScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        inventoryScrollView.addSubview(fullStackView)
        //fullStackView
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.axis = .vertical
        fullStackView.distribution = .fillEqually
        fullStackView.spacing = 10.0
        NSLayoutConstraint.activate([
            fullStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            fullStackView.topAnchor.constraint(equalTo: inventoryScrollView.topAnchor)
        ])
        for i in 0...Int(totalRows){
            let inventoryRowStackView = UIStackView()
            inventoryRowStackView.translatesAutoresizingMaskIntoConstraints = false
            inventoryRowStackView.axis = .horizontal
            inventoryRowStackView.distribution = .fillEqually
            inventoryRowStackView.spacing = 5
            
            if i == (Int(totalRows) - 1){//executes when the last row does not have four items in it.
                let numOfItemsInRow = totalItems - 4 * i
            }//if
            else{
                for _ in 0...4{
                    let inventoryViewToAdd = UIView()
                    inventoryViewToAdd.translatesAutoresizingMaskIntoConstraints = false
                    inventoryViewToAdd.backgroundColor = .green
                    inventoryRowStackView.addArrangedSubview(inventoryViewToAdd)
                }
            }
            fullStackView.addArrangedSubview(inventoryRowStackView)
            
            
        }//for
    }
    
}


