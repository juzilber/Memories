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

        let myCover = DAOCover.sharedInstance.getData();
        if(myCover != nil){
            labelTitle.text = myCover?.title;
            labelName.text = myCover?.name;
            imageProfile.image = UIImage(contentsOfFile: myCover!.imageProfile);}
        
    }

    
    //botao edit que leva pra RegisterCoverVC
    func buttonEdit(sender: AnyObject) {
        
        var controller: RegisterCoverVC = RegisterCoverVC(nibName:"RegisterCoverVC", bundle:NSBundle.mainBundle())
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
   
}
