//
//  DetailViewController.swift
//  StormViewer
//
//  Created by eyal avisar on 13/07/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage:String?
    var imageNumber:Int?
    var totalImages:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "image \(imageNumber!) of \(totalImages!)"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap.toggle()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image was found")
            return
        }
        let vc = UIActivityViewController(activityItems: [selectedImage!, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true, completion: nil)
    }
}
