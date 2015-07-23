//
//  CoverVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class CoverVC: UIViewController {

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageCover: UIImageView!
    @IBOutlet var imageProfile: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        var daoCover = DAOCover()
        let myCover = daoCover.getData();
        if(myCover != nil){
            println("\n\n\n\nAQUI\n\n\n\n")
            println(myCover?.title)
            labelTitle.text = myCover?.title;
            labelName.text = myCover?.name;
            imageProfile.image = UIImage(contentsOfFile: myCover!.imageProfile);
        } else {
            println("salvou nada")
        }
        
        
        imageProfile.userInteractionEnabled = true
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.borderColor = UIColor.clearColor().CGColor
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true

        
        
    }

    
    //botao edit que leva pra RegisterCoverVC
    func buttonEdit(sender: AnyObject) {
        
        var controller: RegisterCoverVC = RegisterCoverVC(nibName:"RegisterCoverVC", bundle:NSBundle.mainBundle())
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
   
}
