//
//  ViewController.swift
//  Calculator
//
//  Created by 陈建 on 2019/2/25.
//  Copyright © 2019 陈建. All rights reserved.
//

import UIKit
@available(iOS 9.0, *)
class ViewController: UIViewController {
    
    let width:CGFloat = (UIScreen.main.bounds.size.width)/4 //屏幕宽度
    let top:CGFloat = UIScreen.main.bounds.height-UIScreen.main.bounds.width //屏幕上方显示高度
    
    var number1:String?
    var number2:String?
    var operators:String?
    var operated:Bool?
    var shouldClear:Bool?
    
    var content:UILabel? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI() //自定义函数
        initData() //自定义函数
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        //初始空白
        number1 = ""
        number2 = ""
        operators = ""
        operated = false
        
    }
    
    func initUI() {
        // 显示板
        content = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: top))
        content!.backgroundColor = UIColor(red: 22/255.0, green: 44/255.0, blue: 32/255.0, alpha: 0.5)
        content!.textColor = UIColor.black
        content!.font = UIFont(name:"HelveticaNeue-Bold", size:50)//设置字体
        content!.text = ""
        content!.lineBreakMode = NSLineBreakMode.byWordWrapping
        content!.numberOfLines = 0  //标签栏的显示行数
        view.addSubview(content!)
        
        // 数字
        for row in 0 ..< 3 {
            for col in 0 ..< 3 {
                let frame:CGRect = CGRect(x: CGFloat(col)*width, y: top+CGFloat(row)*width, width: width, height: width)
                let title:String = String(row*3+col+1)
                createButton(frame:frame, title:title) //调用创建按钮自定义函数
            }
        }
        
        // 运算符
        let operators = ["+","-"];
        for row in 0 ..< 2 {
            for _ in 0 ..< 1 {
                let frame:CGRect = CGRect(x: 3*width, y: top+CGFloat(row)*width*2, width: width, height: width*2)
                let title:String = operators[row]
                createButton1(frame: frame,title: title)
            }
        }
        
        // 其他
        // 小数点
        createButton(frame: CGRect(x: 0, y: top+3*width, width: width, height: width), title: ".")
        
        // 0
        createButton(frame: CGRect(x: width, y: top+3*width, width: width, height: width), title: "0")
        
        // =
        createButton1(frame: CGRect(x: 2*width, y: top+3*width, width: width, height: width), title: "=")
    }
    
    func createButton(frame:CGRect, title:String) -> UIButton {
        let selector:Selector = #selector(self.OnClick(button:))
        let button:UIButton = UIButton.init(frame: frame)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel!.textColor = UIColor.white
        button.setTitle(title, for: UIControl.State.normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1;
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30) //设置字体
        button.addTarget(self, action: selector, for: UIControl.Event.touchUpInside)
        view.addSubview(button)
        return button;
    }
    func createButton1(frame:CGRect, title:String) -> UIButton {
        let selector:Selector = #selector(self.OnClick(button:))
        let button:UIButton = UIButton.init(frame: frame)
        button.backgroundColor = UIColor.orange
        button.titleLabel!.textColor = UIColor.white
        button.setTitle(title, for: UIControl.State.normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1;
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50) //设置字体
        button.addTarget(self, action: selector, for: UIControl.Event.touchUpInside)
        view.addSubview(button)
        return button;
    }
    
    @objc func OnClick(button:UIButton) {
        
        if (shouldClear == true){
            content!.text = ""
            shouldClear = false
        }
        
        let text:String = (button.titleLabel?.text)!
        NSLog("%@",text)
        
        content!.text = content!.text?.appending((text))
        
        if ((text >= "0" && text <= "9")){
            if (operated == false){
                number1 = number1?.appending(text)
            }
            else {
                number2 = number2?.appending(text)
            }
        }
        else if (text == "+" || text == "-"){
            if (operators != ""){
                number1 = doCal()
                number2 = ""
            }
            
            operators = text
            operated = true
        }
        else if (text == "="){
            content!.text = content!.text?.appending(doCal())
            initData()
            shouldClear = true
        }
        else if (text == "."){
            if (operated == false){
                if (number1?.localizedStandardContains(".") == false && number1 != ""){
                    number1 = number1?.appending(text)
                }
                else {
                    content?.text?.remove(at:content!.text!.index (before: content!.text!.endIndex))
                }
            }
            else {
                if (number2?.localizedStandardContains(".") == false && number2 != ""){
                    number2 = number2?.appending(text)
                }
                else {
                    content?.text?.remove(at:content!.text!.index (before: content!.text!.endIndex))
                }
            }
        }
    }
    
    func doCal() -> String {
        let x:CGFloat = StringToFloat(str: number1!)
        let y:CGFloat = StringToFloat(str: number2!)
        if (operators == "+"){
            return String(Float(x+y))
        }
        else {
            return String(Float(x-y))
        }
    }
    
    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat: CGFloat = 0
        
        if let doubleValue = Double(string) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
}


}
