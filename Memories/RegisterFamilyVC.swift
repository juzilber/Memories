//
//  RegisterFamilyVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//
import AVFoundation
import UIKit

class RegisterFamilyVC: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UINavigationControllerDelegate {

    @IBOutlet var familyImg: UIImageView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var recordBtn: UIButton!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var stopBtn: UIButton!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var connetionTxt: UITextField!

    //vai pertimir acessar a camera para escolher imagem para a capa
    var imageFamilyEdit = UIImagePickerController()
  
    var call:String!

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    imageFamilyEdit.delegate = self
    nameTxt.delegate = self
    connetionTxt.delegate = self
    
        // cria um tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped:")
        
        // adiciona o gesture a imageView
        familyImg.addGestureRecognizer(tapGesture)
        
        // faz com que a imageView fique redonda
        familyImg.userInteractionEnabled = true
        familyImg.layer.borderWidth = 1
        familyImg.layer.masksToBounds = false
        familyImg.layer.borderColor = UIColor.clearColor().CGColor
        familyImg.layer.cornerRadius = familyImg.frame.height/4
        familyImg.clipsToBounds = true
        

        playBtn.enabled = false
        stopBtn.enabled = false
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        let soundFilePath =
        docsDir.stringByAppendingPathComponent("sound.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
    
    }
    
    
    //funcao para que o textField feche quando aperta return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //funcao para escolher a imagem. IF apertar botao da imagem redonda, muda a imageView. ELSE muda a imagem do botao
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
         if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if( call == "Imagem Redonda" ){
                familyImg.contentMode = .ScaleAspectFill
                familyImg.image = pickedImage
            }
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        
        // if the tapped view is a UIImageView then set it to imageview
        
        if let imageView = gesture.view as? UIImageView {
            println("Image Tapped")
            
            //Here you can initiate your new ViewController
            
            imageFamilyEdit.allowsEditing = false
            imageFamilyEdit.sourceType = .PhotoLibrary
            
            call = "Imagem Redonda"
            
            presentViewController(imageFamilyEdit, animated: true, completion: nil)
            
        }
        
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordBtn.enabled = true
        stopBtn.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonSave(sender: AnyObject) {
        
//        var family: Family = Family()
//        
//        family.connection = connetionTxt.text
//        family.name = nameTxt.text
//        
//        var daoFamily = DAOFamily()
//        
//        daoFamily.saveData(family, photo: familyImg.image!)
//        
//        let summaryVC = ShowSummaryVC(nibName: "ShowSummaryC", bundle: nil)
//        presentViewController(coverVC, animated: true, completion: nil)
        
    }

    
    @IBAction func cancelRegistration(sender: AnyObject) {
    
        let view = ShowSummaryVC(nibName: "ShowSummaryVC", bundle: nil)
        
        
        presentViewController(view, animated: true, completion: nil)
    
    
    }


    @IBAction func recordAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            playBtn.enabled = false
            stopBtn.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopBtn.enabled = false
        playBtn.enabled = true
        recordBtn.enabled = true
        
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            stopBtn.enabled = true
            recordBtn.enabled = false
            
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }




}
