//
//  VirtualObject.swift
//  ARDemo
//
//  Created by Юрий Альт on 18.12.2021.
//

import SceneKit

class VirtualObject: SCNReferenceNode {
    static let availableObjects: [SCNReferenceNode] = {
        guard let modelsURLs = Bundle.main.url(forResource: "art.scnassets", withExtension: nil) else { return [] }
        
        let fileEnumerator = FileManager().enumerator(at: modelsURLs, includingPropertiesForKeys: nil)!
        
        return fileEnumerator.compactMap { element in
            let url = element as! URL
            guard url.pathExtension == "scn" else { return nil }
            return VirtualObject(url: url)
            print("yes")
        }
    }()
}
