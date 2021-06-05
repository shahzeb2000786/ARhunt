//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController{
  
    let contacts = ["hello","hello","hello","hello","hello","hello","hello" ]
    let contactsTableView = UIScrollView() // view
       
    
   
    func createInventoryItemView() -> UIView{
        let view: UIImageView = {
            let view = UIImageView(image: .checkmark)
            view.widthAnchor.constraint(equalToConstant: self.view.frame.width/4).isActive = true
            view.backgroundColor = .yellow
            return view
        }()
        return view
    }
    func createInventoryStackView()-> UIStackView {
        let inventoryStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = .blue
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 5
            return stackView
        }()
        return inventoryStackView
    }


       override func viewDidLoad() {
           super.viewDidLoad()
    //    view.addSubview(<#T##view: UIView##UIView#>)
           // Do any additional setup after loading the view.
        
           view.backgroundColor = .white
           view.addSubview(contactsTableView)
        
        contactsTableView.contentSize = CGSize(width: view.frame.width, height: 2000)
        contactsTableView.backgroundColor = .green
           contactsTableView.translatesAutoresizingMaskIntoConstraints = false

           contactsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
           contactsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
           contactsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
           contactsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        var v = createInventoryStackView()
        var s = createInventoryStackView()
        contactsTableView.addSubview(v)
        contactsTableView.addSubview(s)

        v.topAnchor.constraint(equalTo: contactsTableView.topAnchor).isActive = true
        v.widthAnchor.constraint(equalTo: contactsTableView.widthAnchor).isActive = true
        v.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        v.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        v.addArrangedSubview(createInventoryItemView())
        v.addArrangedSubview(createInventoryItemView())
        v.addArrangedSubview(createInventoryItemView())
        v.addArrangedSubview(createInventoryItemView())
        
        
        s.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        s.widthAnchor.constraint(equalTo: contactsTableView.widthAnchor).isActive = true
        s.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        s.addArrangedSubview(createInventoryItemView())
        s.addArrangedSubview(createInventoryItemView())
        s.addArrangedSubview(createInventoryItemView())
        s.addArrangedSubview(createInventoryItemView())

//        for _ in (0...3){
//            let stackToAdd: UIStackView = {
//                let view = UIStackView()
//                view.backgroundColor = .red
//                view.axis = .horizontal
//                view.distribution = .fillEqually
//                view.translatesAutoresizingMaskIntoConstraints = false
//                view.spacing = 10
//                return view
//            }()
//            contactsTableView.addSubview(stackToAdd)
//            v.topAnchor.constraint(equalTo: contactsTableView.bottomAnchor).isActive = true
//            v.widthAnchor.constraint(equalTo: contactsTableView.widthAnchor).isActive = true
//            v.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
//            tempStackView = stackToAdd
//        }
}
    
     
}
   
     
  



