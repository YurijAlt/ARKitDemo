//
//  Box.swift
//  ARDemo
//
//  Created by Юрий Альт on 16.12.2021.
//

import SceneKit
import ARKit

class Box: SCNNode {
    
        init(atPosition position: SCNVector3) {
            super.init()
            
            let boxGeometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.green
            
            boxGeometry.materials = [material]
            
            self.geometry = boxGeometry
            
            let physicsShape = SCNPhysicsShape(geometry: self.geometry!, options: nil)
            self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
            self.physicsBody?.categoryBitMask = BitMuskCategory.box
            self.physicsBody?.collisionBitMask = BitMuskCategory.box | BitMuskCategory.plane
            self.physicsBody?.contactTestBitMask = BitMuskCategory.plane
            
            self.position = position
            
    }
             
             required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
             }
