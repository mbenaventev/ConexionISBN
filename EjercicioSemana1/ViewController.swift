//
//  ViewController.swift
//  EjercicioSemana1
//
//  Created by Miguel Benavente Valdés on 27/12/15.
//  Copyright © 2015 Miguel Benavente Valdés. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var txtISBN: UITextField!
    
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var lblMensaje: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //asincrono()
        //input()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func txtBuscar(sender: AnyObject) {
        sincrono()
    }
    
    @IBAction func btnBuscar(sender: AnyObject) {
        sincrono()
    }
    
    func sincrono(){
        txtView.text=""
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + txtISBN.text! //978-84-376-0494-7
        let url = NSURL(string : urls)
        let datos : NSData? = NSData(contentsOfURL: url!)
        
        //let aux: NSString?////
        //let texto:NSString(data : datos!, encoding: NSUTF8StringEncoding )
        
        //Verifica hay conexión si recibe datos nulos
        if datos != nil{
        let texto = NSString(data : datos!, encoding: NSUTF8StringEncoding )
        print(texto!)
        txtView.text = String(texto!)
            
            if texto != "{}"{
            lblMensaje.text="La conexión se realizo correctamente"
            lblMensaje.textColor=UIColor.darkGrayColor()
            }else{
                lblMensaje.text="No se encontró el recurso que buscas"
                lblMensaje.textColor=UIColor.orangeColor()
            }
        }
        else{
            self.lblMensaje.textColor=UIColor.redColor()
            self.lblMensaje.text="No se realizó la conexión"
        }
        
        /*if texto != nil{
            lblMensaje.textColor=UIColor.greenColor()
            lblMensaje.text="La conexión se realizo correctamente"
        }
        else{
            self.lblMensaje.textColor=UIColor.redColor()
            self.lblMensaje.text="No se realizó la conexión"
        }*/
        
        
    }
    
    func asincrono(){
        /*<key>NSAppTransportSecurity</key>
        <dict>
        <--!Permite todas las conexiones-->
        <key>NSAllowsArbitraryLoads</key>
        <true/>
        </dict>
        
        o
        
        <key>NSAppTransportSecurity</key>
        <dict>
        <key>NSExceptionDomains</key>
        <dict>
        <key>dia.ccm.itesm.mx</key>
        <dict>
        <--!Incluir todos los subdominios-->
        <key>NSIncludesSubdomains</key>
        <true/>
        <--!Para que se pueda realizar peticiones http-->
        <key>NSTemporaryExceptionsAllowsInsecureHTTPLoads</key>
        <true/>
        </dict>
        </dict>
        </dict>
        
        */
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + txtISBN.text!//978-84-376-0494-7
        let url = NSURL(string : urls)
        let sesion = NSURLSession.sharedSession()
        let bloque = { (datos:NSData?, resp:NSURLResponse?, error:NSError?) -> Void in
            let texto = NSString(data:datos!, encoding: NSUTF8StringEncoding)
            //print(texto!)
            self.txtView.text =  String(texto!)
            
        }
        
        
        let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
        //print("Antes o Después")
        txtView.text =  "Antes o Después"
    }
    
    func input() -> NSString {
        var keyboard = NSFileHandle.fileHandleWithStandardInput()
        var inputData = keyboard.availableData
        return NSString(data: inputData, encoding:NSUTF8StringEncoding)!
    }

}

