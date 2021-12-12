//
//  ViewController.swift
//  ARDemo
//
//  Created by Юрий Альт on 10.12.2021.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        let scene = SCNScene()
        
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.05)
        let material = SCNMaterial()
        let materialTwo = SCNMaterial()
        let materialThree = SCNMaterial()
        material.diffuse.contents = UIColor.purple
        materialTwo.diffuse.contents = UIColor.yellow
        materialThree.diffuse.contents = UIColor.green
        
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.geometry?.materials = [material, materialTwo, materialThree]
        
        boxNode.position = SCNVector3(0, 0, -0.5)
        
        scene.rootNode.addChildNode(boxNode)
        
        sceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
