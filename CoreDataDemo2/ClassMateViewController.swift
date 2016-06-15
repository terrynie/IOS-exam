//
//  ClassMateViewController.swift
//  CoreDataDemo
//
//  Created by Terry on 16/5/12.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import CoreData

class ClassMateViewController: UITableViewController,UINavigationControllerDelegate {
    var classMates = [ClassMate]()
    var classMate: ClassMate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(NSBundle.mainBundle().resourcePath)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchClassMates() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ClassMate")
        do{
            let fetchedObject = try context.executeFetchRequest(fetchRequest) as! [ClassMate]
            classMates = fetchedObject
            self.tableView.reloadData()
        }
        catch{
            print(error)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchClassMates()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classMates.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ClassMateTableViewCell
        cell.name.text = classMates[indexPath.row].name
        cell.desc.text = classMates[indexPath.row].desc
        cell.price.text = "￥\(classMates[indexPath.row].price!)"
        let imageStr = classMates[indexPath.row].images
        if (imageStr != nil) {
            cell.images.image = UIImage.init(named: imageStr!)
        }else{
            cell.images.image = UIImage.init(named: "no")
        }
        
        let grade = "\(classMates[indexPath.row].grade!)"
        
        switch grade {
        case "0":
            cell.star.image = UIImage(named: "0")
        case "1":
            cell.star.image = UIImage(named: "1")
        case "2":
            cell.star.image = UIImage(named: "2")
        case "3":
            cell.star.image = UIImage(named: "3")
        case "4":
            cell.star.image = UIImage(named: "4")
        default:
            cell.star.image = UIImage(named: "5")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteClassMate(indexPath.row)
            classMates.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        classMate = classMates[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInfo" {
            let indexPath = tableView.indexPathForSelectedRow
            
            var nextPage = segue.destinationViewController as! ViewController
            nextPage.classMate = classMates[(indexPath?.row)!]
            
        
        }
    }
    
    
    func deleteClassMate(rowIndex: Int) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ClassMate")
        
        do {
            let fetchObject = try context.executeFetchRequest(fetchRequest) as! [ClassMate]
            classMates = fetchObject
            context.deleteObject(classMates[rowIndex])
            try context.save()
        }
        catch {
            print("error")
        }
    }

}
