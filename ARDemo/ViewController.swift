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
    var session: ARSession {
        return sceneView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]

        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    
    private func createBox(in scene: SCNScene) {
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        
        boxMaterial.diffuse.contents = UIColor.red
        boxMaterial.specular.contents = UIColor.yellow
        
        let boxNode = SCNNode(geometry: box)
        boxNode.name = "box"
        boxNode.geometry?.materials = [boxMaterial]
        boxNode.position = SCNVector3(0.0, 0.0, -0.5)
        scene.rootNode.addChildNode(boxNode)
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
    
    @IBAction func resetTapped(sender: UIButton) {
        session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { node, _ in
            if node.name == "box" {
                node.removeFromParentNode()
            }
        }
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    @IBAction func addTapped(sender: UIButton) {
        createBox(in: sceneView.scene)
    }

}
