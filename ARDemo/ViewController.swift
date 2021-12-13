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
        
        sceneView.showsStatistics = true

        let scene = SCNScene()
        createFigures(in: scene)
        
//        let sphereGepmetry = SCNSphere(radius: 0.1)
//        let sphereMaterial = SCNMaterial()
//
//
//        sphereMaterial.diffuse.contents = UIImage(named: "head")
//        let sphereNode = SCNNode(geometry: sphereGepmetry)
//        sphereNode.geometry?.materials = [sphereMaterial]
//        sphereNode.position = SCNVector3(0, 0, -1)
//        scene.rootNode.addChildNode(sphereNode)
        
        
//        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.05)
//        let material = SCNMaterial()
//        let materialTwo = SCNMaterial()
//        let materialThree = SCNMaterial()
//        material.diffuse.contents = UIColor.purple
//        materialTwo.diffuse.contents = UIColor.yellow
//        materialThree.diffuse.contents = UIColor.green
//        let boxNode = SCNNode(geometry: boxGeometry)
//        boxNode.geometry?.materials = [material, materialTwo, materialThree]
//        boxNode.position = SCNVector3(0, 0, -1.0)
//        scene.rootNode.addChildNode(boxNode)
//
//        let textGeometry = SCNText(string: "Hello, World!", extrusionDepth: 2.0)
//        let textMaterial = SCNMaterial()
//        textMaterial.diffuse.contents = UIColor.red
////        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
//        let textNode = SCNNode(geometry: textGeometry)
//        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
//        textNode.geometry?.materials = [textMaterial]
//        textNode.position = SCNVector3(0, 0.2, -1.0)
//        scene.rootNode.addChildNode(textNode)
        
        sceneView.scene = scene
    }
    
    private func createFigures(in scene: SCNScene) {
        let array: [SCNGeometry] = [SCNPlane(), SCNSphere(), SCNBox(), SCNPyramid(), SCNTube(),  SCNCone(), SCNTorus(), SCNCylinder(), SCNCapsule()]
        var xCoordinate: Double = 1
        sceneView.autoenablesDefaultLighting = true
        for geometryShape in array {
            let node = SCNNode(geometry: geometryShape)
            
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
            
            node.geometry?.materials = [material]
            node.scale = SCNVector3(0.1, 0.1, 0.1)
            
            node.position = SCNVector3(xCoordinate, 0, -1)
            xCoordinate -= 0.2
            
            scene.rootNode.addChildNode(node)
        }
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
