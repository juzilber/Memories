//
//  ShowFactVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class ShowFactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var screenSize: CGRect!
    var screenHeight: CGFloat!
    var screenWidht: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registra as duas células diferentes
        let cellLeft = UINib(nibName: "FactCellLeft", bundle: nil)
        tableView.registerNib(cellLeft, forCellReuseIdentifier: "CellLeft")
        
        let cellRight = UINib(nibName: "FactCellRight", bundle: nil)
        tableView.registerNib(cellRight, forCellReuseIdentifier: "CellRight")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Calcula a altura da tela para definir a altura de cada célula
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidht = screenSize.width
        print("height: \(screenHeight) \nwidht: \(screenWidht)")
        configureRowHeight()
        
    }
    
    //Define 3 células por página
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    //Carrega as informações em cada célula e define que as de número par ficam na direita, as de número ímpar na esquerda
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            var cell:FactCellRightController!
            cell = tableView.dequeueReusableCellWithIdentifier("CellRight", forIndexPath: indexPath) as! FactCellRightController
            
            cell.dateLabel.text = "0 dez 00"
            cell.subtitleLabel.text = "show do criolo na fundicao progresso um sucesso eta homem bom"
            let photo:UIImage = UIImage(named: "imageB")!
            cell.photoView.image = photo
            
            return cell
        } else {
            var cell:FactCellLeftController!
            cell = tableView.dequeueReusableCellWithIdentifier("CellLeft", forIndexPath: indexPath) as! FactCellLeftController
            
            cell.dateLabel.text = "0 jan 00"
            cell.subtitleLabel.text = "meu primo henrique olha como o sorriso dele é bonito ele é tao feliz"
            let photo:UIImage = UIImage(named: "imageB")!
            cell.photoView.image = photo
            
            return cell
        }
        
        
    }
    
    //Define a altura de cada célula
    func configureRowHeight() {
        tableView.rowHeight = screenHeight/3 - 18
        print(" rowHeight: \(tableView.rowHeight)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
