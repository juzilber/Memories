//
//  RegisterCoverVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegisterCoverVC:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var buttonTeste2: UIButton!
    
    //imageCover = imagem da capa
    let imageCoverEdit = UIImagePickerController()
    
    //imageView é a foto de perfil da pessoa
    @IBOutlet var imageView: UIImageView!
    let myImage = UIImagePickerController()
    
    @IBOutlet var textFieldTitle: UITextField!
    
    @IBOutlet var textFieldName: UITextField!
    
    var chamada:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImage.delegate = self
        
        imageCoverEdit.delegate = self
        
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped:")
        
        // add it to the image view;
        imageView.addGestureRecognizer(tapGesture)
        
        //buttonTeste.backgroundColor = UIColor.yellowColor()
        
        // make image circle
        imageView.userInteractionEnabled = true
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.clearColor().CGColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if( chamada == "Imagem Redonda" ){
                imageView.contentMode = .ScaleAspectFill
                imageView.image = pickedImage
            } else {
                buttonTeste2.setImage(pickedImage, forState: UIControlState.Normal)
                buttonTeste2.imageView?.contentMode = .ScaleAspectFill
            }
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func imageTapped(gesture: UIGestureRecognizer) {
        
        // if the tapped view is a UIImageView then set it to imageview
        
        if let imageView = gesture.view as? UIImageView {
            println("Image Tapped")
            
            //Here you can initiate your new ViewController
            
            myImage.allowsEditing = false
            myImage.sourceType = .PhotoLibrary
            
            chamada = "Imagem Redonda"
            
            presentViewController(myImage, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    @IBAction func buttonSave(sender: AnyObject) {
        
        var cover: Cover = Cover()
        
        cover.title = textFieldTitle.text
        cover.name = textFieldName.text
        
        DAOCover.sharedInstance.saveData(cover, imageProfile: imageView.image!, imageBackground: buttonTeste2.imageView!.image)
        
    }
    
    
    @IBAction func buttonTesteAcao(sender: AnyObject) {
        println("Image Tapped")
        
        imageCoverEdit.allowsEditing = false
        imageCoverEdit.sourceType = .PhotoLibrary
        
        chamada = "Imagem de Trás"
        
        presentViewController(imageCoverEdit, animated: true, completion: nil)
        
    }
    
    
}