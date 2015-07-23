//
//  DAOFact.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//


import UIKit

private let _daoFact = DAOFact()

class DAOFact {
    
    class var sharedInstance: DAOFact {
            return _daoFact
        }
        
        
        //carregar plist de texto(titulo+nome)
        //carregar fotos(perfil+background)
        //load plist, testar, save, excluir, edit
    
    
    
        private var contents : NSMutableDictionary!;
        private let factPath : String;
        private let factPathDoc : String;
        
        //inicializa a classe
        init(){
            var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
            factPathDoc = documentPath.stringByAppendingPathComponent("Fact")
            factPath = documentPath.stringByAppendingPathComponent("Fact/CoverData.plist");
            println(factPath)
            let fileManager = NSFileManager.defaultManager();
            if(fileManager.fileExistsAtPath(factPathDoc)){
                contents = NSMutableDictionary(contentsOfFile: factPathDoc);
            }
            else
            {
                fileManager.createDirectoryAtPath(factPathDoc, withIntermediateDirectories: false, attributes: nil, error: nil)
                createDict()
            }
            
        }
        
        private func createDict(){
            
            contents = NSMutableDictionary();
            contents.writeToFile(factPath, atomically: true);
            
        }
        //pegando as informacoes nome, titulo e imagens para salvar
        //funcao retorna um vetor de fact
    
        func getData() -> [Fact]{
            
            //instanciando a classe Fact(passando informacoes da classe para a plist)
            //vetor de facts que salva facts
            var facts : [Fact] = [Fact]()
            //percorre anos dentro de contents, meses dentro de ano e dias dentro de meses
            for (contentAno, meses) in contents{
                for (contentMes, dias) in meses as! NSMutableDictionary{
                    for (contentDia, foto) in dias as! NSMutableDictionary{
                        
                        var fact : Fact = Fact()
                        
                        //carregando a legenda
                        fact.subtitle = foto["subtitle"] as! String
                    //data
                        fact.photo = foto["photo"] as! [String]
                            facts.append(fact)
                    }
                }
                
            }
            return facts
    }
    
        //funcao pra salvar title, foto, audio[Fact]
//    func saveData(fact : Fact, img : UIImage)
    
//            contents["name"] = cover.name;
//            contents["image"] = cover.title;
//            saveDataImgToPath(imageProfile, name: "user.png");
//            if(imageBackground != nil){
//                saveDataImgToPath(imageBackground!, name: "image.png");
//            }
//            
//            contents.writeToFile(factPath, atomically: true)
//        }
        //funcao para deletar imagem
//        private func deleteImg(name: String){
//            let fileManager = NSFileManager.defaultManager();
//            fileManager.removeItemAtPath(factPathDoc+"/"+name, error: nil)
//        }
//        
//        //funcao pra salvar as imagens
//        private func saveDataImgToPath(img : UIImage, name : String){
//            UIImagePNGRepresentation(img).writeToFile(factPathDoc+"/"+name, atomically: true);
//            
//        }
   
}
