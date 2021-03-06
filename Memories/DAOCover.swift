//
//  DAOCover.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation
import UIKit

private let _daoCover = DAOCover()


class DAOCover {
    
    class var sharedInstance: DAOCover {
        
        return _daoCover
        
    }
    
    //carregar plist de texto(titulo+nome)
    //carregar fotos(perfil+background)
    //load plist, testar, save, excluir, edit
    
    private var contents : NSMutableDictionary!;
    private let coverPath : String;
    private let coverPathDoc : String;
    
    //inicializa a classe
    init(){
        let documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] ;
        coverPathDoc = documentPath.stringByAppendingPathComponent("Cover")
        coverPath = documentPath.stringByAppendingPathComponent("Cover/CoverData.plist");
        print(coverPath)
        print(coverPathDoc)
        let fileManager = NSFileManager.defaultManager();
        
        if(fileManager.fileExistsAtPath(coverPathDoc)){
            print("oi")
            contents = NSMutableDictionary(contentsOfFile: coverPath);
            if( contents == nil ){
                contents = NSMutableDictionary(objects: ["",""], forKeys: ["name", "title"]);
                contents.writeToFile(coverPath, atomically: true);
            }
        }
        else
        {
            do{
                try fileManager.createDirectoryAtPath(coverPathDoc, withIntermediateDirectories: false, attributes: nil)
            }
            catch{
                print("Erro creating directory");
            }
            createDict()
        }
        
    }
    
    private func createDict(){
        print("entrou!")
        contents = NSMutableDictionary(objects: ["",""], forKeys: ["name", "title"]);
        contents.writeToFile(coverPath, atomically: true);
        
    }
    //pegando as informacoes nome, titulo e imagens para salvar
    func getData() -> Cover?{
        
        //instanciando a classe Cover(passando informacoes da classe para a plist)
        let cover = Cover()
        if(contents == nil){
            return nil
        }
        cover.name = contents["name"] as! String;
        cover.title = contents["title"] as! String;
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
        let str = coverPathDoc+"/"+name;
        do{
            try fileManager.removeItemAtPath(str)
        }
        catch{
            print("Error removing file at " + str);
        }
    }
    
    //funcao pra salvar as imagens
    private func saveDataImgToPath(img : UIImage, name : String){
        UIImagePNGRepresentation(img)!.writeToFile(coverPathDoc+"/"+name, atomically: true);
        
    }
}