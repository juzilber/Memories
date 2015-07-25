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
            
            contents = NSMutableDictionary(contentsOfFile: factPath);
            
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
    
    
    
    func getAllData() -> [Fact]{
        
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
                    
                    //carregando a foto
                    
                    fact.photo = foto["photo"] as! [String]
                    
                    // carregando audio
                    
                    fact.audio = (foto["audio"] as! String)
                    
                    
                    
                    facts.append(fact)
                    
                }
                
            }
            
            
            
        }
        
        return facts;
        
    }
    //pegando os anos
    func getAllYears() -> [String]{
    
        
        return contents.allKeys as! [String];

        
    }
    //pegando os meses dentro daquele ano especifico
    func getAllMonthsInYear(year : String) -> [String]{
        
        return (contents[year] as! NSDictionary).allKeys as! [String]
        
    }
    
    
//    
//    func getFactsOfMonth(year : String, month : String) -> [Fact]{
//        
//        let dictFacts = (contents[year] as! NSDictionary)[month] as! NSDictionary;
//        for (contentDia, foto) in dias as! NSMutableDictionary
//     return facts
//    }
}