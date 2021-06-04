//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController{
    let scrollView = UIScrollView()
      let stackView = UIStackView()
     override func viewDidLoad() {
         super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        //Add and setup scroll view
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;

        //Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true;

        //Add and setup stack view
        self.scrollView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.backgroundColor = .green
        self.stackView.distribution = .fill
        self.stackView.spacing = 10;

        //constrain stack view to scroll view
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true;
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true;
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true;
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true;
        
        //constrain width of stack view to width of self.view, NOT scroll view
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
       
        self.stackView.addArrangedSubview(UIImageView(image: .checkmark))
        self.stackView.addArrangedSubview(UIImageView(image: .checkmark))
        self.stackView.addArrangedSubview(UIImageView(image: .checkmark))

        


        
        let v = UIView()
        v.backgroundColor = .yellow
        v.frame.size = CGSize(width: self.view.frame.width * 3/4, height: self.view.frame.height/5)
        v.backgroundColor = .yellow
        self.stackView.addArrangedSubview(v)
        self.stackView.addArrangedSubview(v)
        self.stackView.addArrangedSubview(v)
        self.stackView.addArrangedSubview(v)
        self.stackView.addArrangedSubview(v)

        
//        let inventoryRowStackView = UIStackView()
//        inventoryRowStackView.translatesAutoresizingMaskIntoConstraints = false
//        inventoryRowStackView.axis = .horizontal
//        inventoryRowStackView.distribution = .fillEqually
//        inventoryRowStackView.spacing = 5
//        inventoryRowStackView.backgroundColor = .yellow
//        inventoryRowStackView.heightAnchor.constraint(equalToConstant: self.view.frame.height/10)
//        inventoryRowStackView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height/10)
//        self.stackView.addArrangedSubview(inventoryRowStackView)
    
     }
    
     
   
     
  
}


