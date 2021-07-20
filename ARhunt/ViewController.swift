//
//  ViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/7/21.
//
import UIKit
import RealityKit
import ARKit
import FirebaseFirestore
import CoreLocation
class ViewController: UIViewController {
    
    //@IBOutlet var arView: ARView!
    var arView: ARView!
    var locationManager: CLLocationManager?
    let bronzeCoin = try! Experience.loadScene()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(arView.scene.anchors.first?.name)
        print(arView.scene.findEntity(named: "GoldCoin"))
         let touchLocation = touches.first?.location(in: arView)
             let tappedEntity = arView.hitTest(touchLocation!, query: .nearest, mask: .default).first?.entity
        print(tappedEntity?.name)
    }
    @objc func onTap(_ sender: UITapGestureRecognizer) {
                
        let tapLocation: CGPoint = sender.location(in: arView)
                let result: [CollisionCastHit] = arView.hitTest(tapLocation)

                guard let hitTest: CollisionCastHit = result.first
                else { return }

                let entity: Entity = hitTest.entity
                print(entity.name)
        }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        bronzeCoin.bronzeCoin?.scale = [2,2,2]
        bronzeCoin.bronzeCoin?.name = "Coin"
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        arView = ARView()
        self.view.addSubview(arView)
        self.arView.isUserInteractionEnabled = true
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
           self.arView.addGestureRecognizer(tapGesture)
        arView.translatesAutoresizingMaskIntoConstraints = false
        arView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        arView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        arView.scene.anchors.append(bronzeCoin)
    }

}

//extension for functions used to add coins onto the AR View
extension ViewController{
   
        
    func addCoinToView(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//        if(Float(latitude) > 39.7550 && Float(latitude) < 39.7675 && Float(longitude) < -77.5400 && Float(longitude) > -77.5543 ){
        let cubeMesh = MeshResource.generateBox(size: 81)
        var cubeMaterial = SimpleMaterial(color:.white,isMetallic: false)
        let cubeEntity = ModelEntity(mesh:cubeMesh,materials:[cubeMaterial])
        cubeEntity.generateCollisionShapes(recursive: false)
        cubeEntity.name = "this is a cube"
        
        
        
        let randNum = Float.random(in: 0.0...1.0)
        var entity: Entity
        let anchor = AnchorEntity()
        do{
            entity = try Experience.loadGoldCoin()
            anchor.addChild(entity)
        }catch let error{
            fatalError(error.localizedDescription)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(onTap))
               arView.addGestureRecognizer(tapGesture)
        arView.scene.addAnchor(anchor)
        arView.scene.addAnchor(anchor)
        print(entity.children)
        let SilverCoin = entity.findEntity(named: "GoldCoin")!
        SilverCoin.position.y += randNum
        let timer = Timer.scheduledTimer(withTimeInterval: 0.0022, repeats: true, block: { timer in
            let curOrientationAngle = SilverCoin.orientation.angle
            SilverCoin.orientation = simd_quatf(angle: (curOrientationAngle + .pi/200).truncatingRemainder(dividingBy: (2 * 3.14159265)),     /* 45 Degrees */
                                                                   axis: [1, 0, 0])
            })
            print("You are on top of an AR object")
        }//TIMER

   // }//IF
}
extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .denied: // Setting option: Never
      print("LocationManager didChangeAuthorization denied")
    case .notDetermined: // Setting option: Ask Next Time
      print("LocationManager didChangeAuthorization notDetermined")
    case .authorizedWhenInUse: // Setting option: While Using the App
      print("LocationManager didChangeAuthorization authorizedWhenInUse")
      locationManager?.requestLocation()
    case .authorizedAlways: // Setting option: Always
      print("LocationManager didChangeAuthorization authorizedAlways")
      locationManager?.requestLocation()
    case .restricted: // Restricted by parental control
      print("LocationManager didChangeAuthorization restricted")
    default:
      print("LocationManager didChangeAuthorization")
    }
  }

  // Step 7: Handle the location information
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("LocationManager didUpdateLocations: numberOfLocation: \(locations.count)")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    locations.forEach { (location) in
        addCoinToView(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
      print("LocationManager didUpdateLocations: \(dateFormatter.string(from: location.timestamp)); \(location.coordinate.latitude), \(location.coordinate.longitude)")
      print("LocationManager altitude: \(location.altitude)")
      print("LocationManager floor?.level: \(location.floor?.level)")
      print("LocationManager horizontalAccuracy: \(location.horizontalAccuracy)")
      print("LocationManager verticalAccuracy: \(location.verticalAccuracy)")
      print("LocationManager speedAccuracy: \(location.speedAccuracy)")
      print("LocationManager speed: \(location.speed)")
      print("LocationManager timestamp: \(location.timestamp)")
      print("LocationManager courseAccuracy: \(location.courseAccuracy)") // 13.4
      print("LocationManager course: \(location.course)")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("LocationManager didFailWithError \(error.localizedDescription)")
    if let error = error as? CLError, error.code == .denied {
       // Location updates are not authorized.
      // To prevent forever looping of `didFailWithError` callback
       locationManager?.stopMonitoringSignificantLocationChanges()
       return
    }
  }
}
