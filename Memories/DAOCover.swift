//
//  DAOCover.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation
import UIKit

class DAOCover{

    
    //carregar plist de texto(titulo+nome)
    //carregar fotos(perfil+background)
    //load plist, testar, save, excluir, edit
    
    private var contents : NSMutableDictionary!;
    private let coverPath : String;
    private let coverPathDoc : String;
    
    //inicializa a classe
    init(){
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        coverPathDoc = documentPath.stringByAppendingPathComponent("Cover")
        coverPath = documentPath.stringByAppendingPathComponent("Cover/CoverData.plist");
        println(coverPath)
        let fileManager = NSFileManager.defaultManager();
        
        if(!fileManager.fileExistsAtPath(coverPathDoc)){
            println("oi1")
            contents = NSMutableDictionary(contentsOfFile: coverPathDoc);
            if( contents == nil ){
                println("teste1")
                contents = NSMutableDictionary(objects: ["",""], forKeys: ["name", "title"]);
                contents.writeToFile(coverPath, atomically: true);
            }
        }
        else
        {
            println("teste 2")
            fileManager.createDirectoryAtPath(coverPathDoc, withIntermediateDirectories: false, attributes: nil, error: nil)
            createDict()
        }
        
    }
    
    private func createDict(){
        println("entrou!!")
        contents = NSMutableDictionary(objects: ["",""], forKeys: ["name", "title"]);
        contents.writeToFile(coverPath, atomically: true);
        
    }
    //pegando as informacoes nome, titulo e imagens para salvar
    func getData() -> Cover?{
        
        //instanciando a classe Cover(passando informacoes da classe para a plist)
        var cover = Cover()
        if(contents == nil){
            println("teste 3")
            return nil
            
        }
        println("teste 4")
        cover.name = contents["name"] as! String;
        cover.title = contents["title"] as! String;
        if(cover.title.isEmpty){
            return nil;
        }
        cover.imageProfile = coverPathDoc + "/user.png";
        let path = coverPathDoc + "/image.png";
        if(NSFileManager.defaultManager().fileExistsAtPath(path)){
            cover.imageBackground = path;
            
        }
        else{
            cover.imageBackground = "";
        }
        
        return cover;
        
    }
    
     //funcao pra salvar titulo, nome
    func saveData(cover : Cover, imageProfile: UIImage, imageBackground: UIImage?){
        println("teste 5")
        
        contents["name"] = cover.name;
        contents["title"] = cover.title;
        saveDataImgToPath(imageProfile, name: "user.png");
        if(imageBackground != nil){
            saveDataImgToPath(imageBackground!, name: "image.png");
        }
        
        contents.writeToFile(coverPath, atomically: true)
    }
    //funcao para deletar imagem
    private func deleteImg(name: String){
        let fileManager = NSFileManager.defaultManager();
        fileManager.removeItemAtPath(coverPathDoc+"/"+name, error: nil)
    }
    
    //funcao pra salvar as imagens
    private func saveDataImgToPath(img : UIImage, name : String){
        UIImagePNGRepresentation(img).writeToFile(coverPathDoc+"/"+name, atomically: true);
        
    }
}