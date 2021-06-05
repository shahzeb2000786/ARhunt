//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController{
  
    let sampleData = ["hello","hello","hello","hello","hello","hello","hello" ,"hello","hello","hello","hello","hello","hello","hello"]
    let inventoryScrollView = UIScrollView() // view
    
    func createInventoryItemView(itemImage: UIImage) -> UIView{
        let view: UIImageView = {
            let view = UIImageView(image: itemImage)
            view.widthAnchor.constraint(equalToConstant: self.view.frame.width/4).isActive = true
            view.backgroundColor = .yellow
            return view
        }()
        return view
    }//createInventoryItemView
    
    func createInventoryStackView()-> UIStackView {
        let inventoryStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = .blue
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 0
            return stackView
        }()
        return inventoryStackView
    }//createInventoryStackView


    override func viewDidLoad() {
        super.viewDidLoad()
        let totalInventoryItems = sampleData.count
        let totalInventoryRows = Int(ceil(Float(totalInventoryItems)/4))
        let itemCountInLastRow = totalInventoryItems % 4
        
        
        view.backgroundColor = .white
        view.addSubview(inventoryScrollView)
        
        inventoryScrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        inventoryScrollView.backgroundColor = .green
        inventoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        inventoryScrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        inventoryScrollView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        inventoryScrollView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        inventoryScrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        var tempStackView = UIStackView()
        for rowStackViewIndex in (0...totalInventoryRows - 1){
            let stackToAdd = createInventoryStackView()
            inventoryScrollView.addSubview(stackToAdd)
            var totalItemsInRow = 4
            if rowStackViewIndex == totalInventoryRows - 1{
                totalItemsInRow = itemCountInLastRow
            }
            
            for itemToAddToRowIndex in (0...3){
                itemToAddToRowIndex >= totalItemsInRow ?
                    stackToAdd.addArrangedSubview(createInventoryItemView(itemImage: UIImage.add)):
                    stackToAdd.addArrangedSubview(createInventoryItemView(itemImage: UIImage.checkmark))
            }//for loop
            
            if rowStackViewIndex == 0{
                stackToAdd.topAnchor.constraint(equalTo: inventoryScrollView.bottomAnchor, constant: 20).isActive = true
            }else{
                stackToAdd.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 20).isActive = true
            }
            stackToAdd.widthAnchor.constraint(equalTo: inventoryScrollView.widthAnchor).isActive = true
            stackToAdd.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
            tempStackView = stackToAdd
        }//for loop
       
    }//viewDidLoad
    
     
}
   
     
  



