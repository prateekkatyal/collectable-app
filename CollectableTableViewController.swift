//
//  CollectableTableViewController.swift
//  Collector
//
//  Created by Prateek Katyal on 10/10/18.
//  Copyright © 2018 Prateek Katyal. All rights reserved.
//

import UIKit

class CollectableTableViewController: UITableViewController {
    
    
    var allCollectables = [Collectable]()

    // ViewWillAppear added instead of ViewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        getCollectables()
    }
    
    
    func getCollectables() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let dataFromCollectable = try? context.fetch(Collectable.fetchRequest()) {
                
                if let tempToDos = dataFromCollectable as? [Collectable] {
                    allCollectables = tempToDos
                    
                    tableView.reloadData()
                    
                }
                
            }
            
        }
        
        
    }
    

    // MARK: - Table view data source

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        // What should be displayed in cell?
        
        cell.textLabel?.text = allCollectables[indexPath.row].title
        
        // Displaying the image in our cell
        // Converting the image type so that it can be used
        
        if let data = allCollectables[indexPath.row].image {
            
            cell.imageView?.image = UIImage(data: data)
            
        }
        
      
        
        return cell
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return allCollectables.count
        
    }

    
    // function so that if someone taps on the cell - just deselect it
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // deselect row command
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // function used to delete something when user swipes left on cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // if someone is trying to delete something
        
        if editingStyle == .delete {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let selectedCollectable = allCollectables[indexPath.row]
                
                // Delete the selected cell from coreData
                
                context.delete(selectedCollectable)
                
                // Save data in core Data Entity after changes
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
                getCollectables()
            
        }
        
    }

}
}
