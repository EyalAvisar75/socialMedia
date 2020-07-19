//
//  ViewController.swift
//  StormViewer
//
//  Created by eyal avisar on 13/07/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("storm") {
                //this is a picture to load
                pictures.append(item)
            }
        }
        
        print(pictures)
        var current = pictures.count
        
        while current >= 1 {
            for index in 0..<current {
                if pictures[index].contains(String(current)) {
                    (pictures[current - 1], pictures[index]) = (pictures[index], pictures[current - 1])
                    current -= 1
                    print(pictures)
                    break
                }
            }
            
        }
        print(pictures)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageNumber = indexPath.row
            vc.totalImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

