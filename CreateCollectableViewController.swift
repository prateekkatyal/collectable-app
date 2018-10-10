//
//  CreateCollectableViewController.swift
//  Collector
//
//  Created by Prateek Katyal on 10/10/18.
//  Copyright © 2018 Prateek Katyal. All rights reserved.
//

import UIKit

class CreateCollectableViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    // View controller created by apple to let user choose an image.
    
    var pickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerController.delegate = self
        
        
    }
    
    // Someone picked the image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Extracting data from the above mentioned info dictionary
        
        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            
        }
        
        // Dismiss the Pickerview controller after user has picked image
        
        pickerController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func mediaTapped(_ sender: Any) {
        
        
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        // Saving stuff into CoreData Entity
        
        // creating the reference to the context
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let collectable = Collectable(context : context)
            
            collectable.title = titleTextField.text
            
            // As the .image data type is binary data we need to add this line of code rather than simply setting it equal to something
            
            collectable.image = imageView.image?.jpegData(compressionQuality: 1.0)
            
            // Command to actually save it into our entity
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            
        }
        
        // Go back to the previous view controller now
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
