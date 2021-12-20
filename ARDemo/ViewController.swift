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
    
    var planes = [Plane]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        setupGestures()
    }
    
    func setupGestures() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeVirtualObject(tapGesture:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    
    @objc func placeVirtualObject(tapGesture: UITapGestureRecognizer) {
        let sceneView = tapGesture.view as! ARSCNView
        let location = tapGesture.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        guard let hitResult = hitTestResult.first else { return }
        createVirtualObject(hitResult: hitResult)
    }
    
    func createVirtualObject(hitResult: ARHitTestResult) {
        let position = SCNVector3(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y,
            hitResult.worldTransform.columns.3.z
        )
        
        let virtualObject = VirtualObject.availableObjects[2]
        
        virtualObject.load()
        virtualObject.position = position
        
        if let particleSystem = SCNParticleSystem(named: "Smoke.scnp", inDirectory: nil), let smokeNode = virtualObject.childNode(withName: "SmokeNode", recursively: true) {
            smokeNode.addParticleSystem(particleSystem)
        }
        
        sceneView.scene.rootNode.addChildNode(virtualObject)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}


//MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)
        
        self.planes.append(plane)
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
        }.first
        
        guard plane != nil else { return }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
    
}

extension ViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if contact.nodeB.physicsBody?.collisionBitMask == BitMuskCategory.box {
            nodeA.geometry?.materials.first?.diffuse.contents = UIColor.red
            return
        }
        nodeB.geometry?.materials.first?.diffuse.contents = UIColor.red
    }
}
