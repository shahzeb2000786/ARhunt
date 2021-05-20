//
//  ViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/7/21.
//

import UIKit
import RealityKit
import FirebaseFirestore
class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let boxAnchor = try! Experience.loadBox()
      //  let db = Firestore.firestore()

       
//         Load the "Box" scene from the "Experience" Reality File
//
//
//        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
            boxAnchor.children[0].transform = Transform(pitch: 0,
                                                        yaw: 0,
                                                       roll: .pi/4)
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
            let curOrientationAngle = boxAnchor.coin?.orientation.angle
            

            boxAnchor.coin?.orientation = simd_quatf(angle: (curOrientationAngle! + .pi/100).truncatingRemainder(dividingBy: (2 * 3.14159265)),     /* 45 Degrees */
                                                          axis: [1, 0, 0])
            print(boxAnchor.coin?.orientation.vector);
        })
      
       // timer.fire()



    }//viewDidLoad
    
    
   

    
    //        let anchor = AnchorEntity(plane: .horizontal, classification: .floor, minimumBounds: [0.2,0.2])
    //        var cards: [Entity] = []
    //
    //        for _ in 1...4{
    //            let box = MeshResource.generateBox(width: 0.25, height: 2.5, depth: 0.25)
    //            let metalMaterial = SimpleMaterial(color: .cyan, isMetallic: true)
    //            let model = ModelEntity(mesh: box, materials: [metalMaterial])
    //            cards.append(model)
    //        }//for
    //        for (index, card) in cards.enumerated(){
    //            let x = Float(index % 2)
    //            let z = Float(index / 2)
    //
    //            card.position = [x*1, 0, z*1]
    //            anchor.addChild(card)
    //        }
    //        arView.scene.addAnchor(anchor)
}
