//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Terry on 16/5/12.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate {
    
    var classMate:ClassMate!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var images: UIButton!
    @IBOutlet weak var test: UIImageView!
    @IBOutlet weak var desp: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    var grade: Int16! = 0
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var stars1: UIImageView!
    @IBOutlet weak var stars2: UIImageView!
    @IBOutlet weak var stars3: UIImageView!
    @IBOutlet weak var stars4: UIImageView!
    @IBOutlet weak var stars5: UIImageView!
    
    var stars: [UIImageView] = []
    var buttons: [UIButton] = []
    
    var buttonImage: String!
    var imageName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        stars.append(stars1)
        stars.append(stars2)
        stars.append(stars3)
        stars.append(stars4)
        stars.append(stars5)
        
        buttons.append(star1)
        buttons.append(star2)
        buttons.append(star3)
        buttons.append(star4)
        buttons.append(star5)
        buttons.append(images)
        buttons.append(addButton)
        
        if classMate != nil{
            
            for button in buttons {
                button.hidden = true
            }
            
            self.name.text = classMate.name
            self.price.text = "\(classMate.price!.stringValue)"
            self.desp.text = classMate.desc
            self.test.image = UIImage(contentsOfFile: (classMate?.images!)!)
            let temp = Int((classMate.grade?.shortValue)!)
            for i in 0..<temp {
                stars[Int(i)].image = UIImage(named: "star_light")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func add() {
        if name.text == nil {
            let actionSheet = UIActionSheet(title: "请输入餐品名称",delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
            actionSheet.showInView(self.view)
            return
        }
        else if Float(price.text!) == nil {
            let actionSheet = UIActionSheet(title: "请输入合法数字",delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
            actionSheet.showInView(self.view)
            return
        }
        else if desp.text == nil {
            let actionSheet = UIActionSheet(title: "请添加菜品描述",delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
            actionSheet.showInView(self.view)
            return
        }
        else if imageName == nil {
            let actionSheet = UIActionSheet(title: "请添加图片",delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
            actionSheet.showInView(self.view)
            return
        }
        
        
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context  = delegate.managedObjectContext
        let newClassMate = NSEntityDescription.insertNewObjectForEntityForName("ClassMate", inManagedObjectContext: context) as! ClassMate
        newClassMate.name = name.text
        newClassMate.price = NSNumber(float: Float(price.text!)!)
        newClassMate.desc = desp.text
        newClassMate.grade = NSNumber(short: grade)
        newClassMate.images = imageName
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func getImage(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil,delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相机","相册")
        actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
        actionSheet.showInView(self.view)
        
    }
    
    @IBAction func addStar(sender: AnyObject) {
        for i in 0..<5 {
            stars[i].image = UIImage(named: "star_dark")
        }
        grade = Int16(sender.tag + 1)
        for i in 0 ..< sender.tag+1 {
            stars[i].image = UIImage(named: "star_light")
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        //使用相册
        if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            picker.dismissViewControllerAnimated(true, completion: nil)
            let getImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let getImageName = name.text! + ".jpg"
            saveImage(getImage, newSize: CGSize(width: 300,height: 160), percent: 0.5, imageName: getImageName)
        }else {
            //使用相机
            imageName = OCCamera.imagePicker(picker, didFinishPickingMediaWithInfo: info, andImageView: self.test, andImageName: self.name.text)
            test.image = UIImage.init(named: imageName)
        }
    }
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            //调用摄像头
            OCCamera.addImage(self)
        }else if buttonIndex == 2 {
            //从相册选择
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName:String) {
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = UIImageJPEGRepresentation(newImage, percent)
        let fullPath = NSHomeDirectory() + "/Documents/" + imageName
        
        imageData!.writeToFile(fullPath, atomically: false)
        self.buttonImage = fullPath
        self.imageName = fullPath
        
        test.image = UIImage(named: fullPath)
    }
    
    override func viewWillAppear(animated: Bool) {
//        images.imageView?.image = (buttonImage == nil) ? nil : buttonImage!
        if (buttonImage != nil) {
            images.imageView?.image = UIImage(named: buttonImage!)
        }
    }
    
    
}


