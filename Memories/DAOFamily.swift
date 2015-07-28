//
//  DAOFamily.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//


import Foundation
import UIKit


class DAOFamily : DAOAuxiliar {
    
    
    //carregar foto de perfil de familia/amigos
    //carregar descricao
    //carregar audio
    
    
    private var contents : NSMutableDictionary!;
    
    private let familyPath : String;
    
    private let familyPathDoc : String;
    
    override init(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        var imgPath:String = documentPath
        familyPathDoc = documentPath.stringByAppendingPathComponent("Family")
        
        familyPath = documentPath.stringByAppendingPathComponent("Family/FamilyData.plist");
        
        println(familyPath)
    }
    
    //inicializa a classe

        
     func loadPlist() ->  NSMutableDictionary?{
        var pessoas : NSMutableDictionary = contents["pessoas"] as! NSMutableDictionary;
        return pessoas;
    }
    
    func getDataArray() -> Array<AnyObject> {
        
        var res = setUpPessoa();
        var pessoas : Array = Array <Family>();
        
        for (id, _) in res.dict {
            var pessoa : Family =  getDataById(id as! String);
            pessoas.append(pessoa);
        }
        
        return pessoas;
    }
    
    func getDataById (id: String) -> Family {
        
        var pessoa : Family = Family();
        
        var res = setUpPessoa();
        var pess: NSDictionary = res.dict[id] as! NSDictionary;
        
        pessoa.id = id.toInt()!;
        pessoa.photos = pess["imagem"] as! String;
        pessoa.subtitle = pess["nome"] as! String;
        pessoa.connection = pess["parentesco"] as? String;
        
        if (!(pess["imagem"] as! String).isEmpty) {
            var pImg: String = res.path.stringByAppendingPathComponent(pess["imagem"] as! String);
            pessoa.photos = pImg;
        }
        
        return pessoa;
    }
    
   
    
    func saveData(family : Family, img : UIImage){
        var pessoasDict : NSMutableDictionary = self.loadPlist()!;
        var pessoaDict : NSMutableDictionary = NSMutableDictionary();
        
        var pessoa = family as Family;
        
        var newId : String = ""
        if(pessoa.id != nil){
            newId = String(pessoa.id);
            
            (contents["pessoas"] as! NSMutableDictionary).removeObjectForKey(String(pessoa.id));
            contents.writeToFile(familyPath, atomically: true);
            
        }
        else{
            newId = getFreeIdInDict(pessoasDict);
        }
        
        if(pessoa.photos == nil){
            pessoaDict.setValue("", forKey: "imagem");
        }else{
            pessoaDict.setValue(pessoa.photos, forKey: "imagem");
        }
        
        pessoaDict.setObject(pessoaDict, forKey: newId);
        contents.setObject(pessoasDict, forKey: "pessoas");
        contents.writeToFile(familyPath, atomically: true);
    }
    
    
    
    func deleteDataById(id: AnyObject) {
        
        var imgPath = getPessoasImagePath().stringByAppendingPathComponent(((contents["pessoas"] as! NSDictionary)[String(id as! Int)] as! NSDictionary)["imagem"] as! String);
        NSFileManager.defaultManager().removeItemAtPath(imgPath, error: nil);
        (contents["pessoas"] as! NSMutableDictionary).removeObjectForKey(String(id as! Int));
        contents.writeToFile(familyPath, atomically: true);
    }
    
    func copyImgToDocuments(img : UIImage) -> String{
        var imgPath : String = getPessoasImagePath();
        var id = getFreeIdInDict(getImgDictionary());
        id = id.stringByAppendingFormat(".png");
        imgPath = imgPath.stringByAppendingPathComponent(id);
        UIImagePNGRepresentation(img).writeToFile(imgPath, atomically: true);
        return id;
    }
    
    private func getImgDictionary() -> NSMutableDictionary{
        var imgPath : String = getPessoasImagePath();
        var contentsArray : NSArray = NSFileManager.defaultManager().contentsOfDirectoryAtPath(imgPath, error: nil)!;
        var imgDict:NSMutableDictionary = NSMutableDictionary();
        for (var id) in contentsArray{
            let str:String = imgPath.stringByAppendingPathComponent(id as! String);
            id = id.substringToIndex(count(id as! String) - 4);
            if let img = UIImage(contentsOfFile: str){
                imgDict.setObject(img, forKey: id as! String);
            }
        }
        return imgDict;
    }
    private func getPessoasImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgPessoa");
        
        return imgPath;
    }
    
    private func setUpPessoa() -> (dict: NSMutableDictionary, path: String){
        var pessoasDict : NSMutableDictionary  = self.loadPList()!;
        var imgPath : String = getPessoasImagePath();
        
        return(pessoasDict, imgPath);
    }
}