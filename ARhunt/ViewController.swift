//
//  ViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/7/21.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        
//        let boxAnchor = try! Experience.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        let anchor = AnchorEntity(plane: .horizontal, classification: .floor, minimumBounds: [0.2,0.2])
        var cards: [Entity] = []
        
        for _ in 1...4{
            let box = MeshResource.generateBox(width: 0.25, height: 2.5, depth: 0.25)
            let metalMaterial = SimpleMaterial(color: .cyan, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            cards.append(model)
        }//for
        for (index, card) in cards.enumerated(){
            let x = Float(index % 2)
            let z = Float(index / 2)
            
            card.position = [x*1, 0, z*1]
            anchor.addChild(card)
        }
        arView.scene.addAnchor(anchor)

    }//viewDidLoad
}
