//
//  RegisterFamilyVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegisterFamilyVC: UIViewController {

    @IBOutlet var cancel: UIButton!

    let imageFamilyEdit = UIImagePickerController()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func cancelRegistration(sender: AnyObject) {
    
        let view = ShowSummaryVC(nibName: "ShowSummaryVC", bundle: nil)
        
        //view.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        presentViewController(view, animated: true, completion: nil)
    
    
    }







}
