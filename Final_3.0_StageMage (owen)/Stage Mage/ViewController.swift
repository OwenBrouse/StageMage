//  ViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-10-30.
//  Copyright © 2018 KingByngInc. All rights reserved.



//SetUp#################################################################################################################################################SetUp
//SetUp#################################################################################################################################################SetUp
//Import------------------------------------------------------------------------------------------------------------------------------------------Import
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    //VariableCreation/definition--------------------------------------------------------------------------------------------VariableCreation/definition
        //StoryBoardObjects........................................................................................................StoryBoardObjects
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var MenuView: UIView!
        @IBOutlet weak var MenuButton: UIButton!
        @IBOutlet weak var SaveButton: UIButton!
        @IBOutlet weak var OpenButton: UIButton!
        @IBOutlet weak var CurserButton: UIButton!
        @IBOutlet weak var RotateButton: UIButton!
        @IBOutlet weak var CameraButton: UIButton!
        @IBOutlet weak var ActorButton: UIButton!
        @IBOutlet weak var SetButton: UIButton!
        @IBOutlet weak var PropButton: UIButton!
        @IBOutlet weak var AnimationButton: UIButton!
        @IBOutlet weak var LightButton: UIButton!
        @IBOutlet weak var CoulorButton: UIButton!
        @IBOutlet weak var TrashButton: UIButton!
    @IBOutlet weak var PropertyMenuView: UIView!
        @IBOutlet weak var nameInfoBox: UITextField!
        @IBOutlet weak var xPosInfoBox: UITextField!
        @IBOutlet weak var yPosInfoBox: UITextField!
        @IBOutlet weak var widthInfoBox: UITextField!
        @IBOutlet weak var heightInfoBox: UITextField!
        @IBOutlet weak var angleInfoBox: UITextField!
        @IBOutlet weak var colourSelectOne: UISegmentedControl!
        @IBOutlet weak var colourSelectTwo: UISegmentedControl!
        @IBOutlet weak var colourSelectThree: UISegmentedControl!
        @IBOutlet weak var colourSelectFour: UISegmentedControl!
    @IBOutlet weak var aniMenu: UIView!
        @IBOutlet weak var aniScroll: UIScrollView!
            @IBOutlet weak var aniScrollView: UIView!
                @IBOutlet weak var aniHeight: NSLayoutConstraint!
                @IBOutlet weak var addAni: UIButton!
                @IBOutlet weak var addCurtainAni: UIButton!
        @IBOutlet weak var playButton: UIButton!
        @IBOutlet weak var pauseButon: UIButton!
        @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var MyView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //listsAndOther................................................................................................................listsAndOther
    var items = [Item]()
    var animations = [Animator]()
    var c = [UISegmentedControl]()
    
    var aniStep = 0
    var animating = false
    
    let arrowRot = UIView()
    var arrow = UIImageView()

    var c1 = UIImageView()
    var ch1 = UIView()
    var c2 = UIImageView()
    var ch2 = UIView()
    @IBOutlet weak var label: UILabel!
    
    var mString = String()
    var savedItem = [Any]()
    var savedAnime = [Any]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        var secController = segue.destination as! SecondViewController
        
        // Pass the selected object to the new view controller.
        secController.loadItem = savedItem
        secController.loadAnime = savedAnime
        
    }
    
    //"VoidSetup"////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"VoidSetup"
    @objc override func viewDidLoad() {
        items.append(Item(x: -100000, y: -100000, width: 0, height: 0, angle : 0, name: "", type: "")!)
        
        savedItem = items
        savedAnime = animations
        
        label.text = mString
        
        //TouchScreenGestuirs (Creation/definition)
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tap))
        let panGesture = UIPanGestureRecognizer (target: self, action: #selector(Pan))
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
        
        //Scroll View (Creation/definition)
        scrollView.isScrollEnabled = false
        self.scrollView.minimumZoomScale = 0.7
        self.scrollView.maximumZoomScale = 5
        
        //colours selection menu (Creation/definition)
        c.append(colourSelectOne)
        c.append(colourSelectTwo)
        c.append(colourSelectThree)
        c.append(colourSelectFour)
        for i in 0...c.count-1{c[i].selectedSegmentIndex = -1; c[i].isEnabled = false}
        
        c1 = UIImageView.init(image: UIImage(named: "Set Shapes"))
        c1.frame = CGRect(x: 0, y: 0, width: 225, height: 15)
        ch1.frame = CGRect(x: 17*BackgroundImage.frame.width/30, y: BackgroundImage.frame.height/6.5, width: 0, height: 0)
        ch1.transform = CGAffineTransform(rotationAngle: 1.25)
        ch1.addSubview(c1)
        BackgroundImage.addSubview(ch1)
        
        c2 = UIImageView.init(image: UIImage(named: "Set Shapes"))
        c2.frame = CGRect(x: 0, y: 0, width: 190, height: 15)
        ch2.frame = CGRect(x: 3*BackgroundImage.frame.width/4, y: BackgroundImage.frame.height/1.8, width: 0, height: 0)
        ch2.transform = CGAffineTransform(rotationAngle: 3.78)
        ch2.addSubview(c2)
        BackgroundImage.addSubview(ch2)
        
        //menu manegment
        PropertyMenuView.isHidden = true
        aniMenu.isHidden = true
        MenuView.isHidden = false
//        MenuButton.frame.width = MenuView.frame.height
//        MenuButton.frame.height = MenuView.frame.height
        MenuButton.frame.origin.x = MenuView.frame.width/20
        MenuButton.frame.origin.y = MenuView.frame.height
        
        // reading and writing STRINGS to txt file
        /*
        let fileName = "savedProjects"
        let documentDirURL = try!FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("FilePath: \(fileURL.path)")
       
        let writeString = "Write this text to the file in Swift"
        do {
            // Write to the file
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("failed to write")
            print(error)
        }
        
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError{
            print("failed to find file")
            print(error)
        }
        
        print(readString)
 */
        
        // Read and write OBJECTS to file
        /*
        let randomFileName = UUID().uuidString
        let savePath = documentDirURL.appendingPathComponent(randomFileName)
    
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: true)
            
            try data.write(to: savePath)
        }catch {
                print("couldn't write file")
        }
        
        do {
            if let loadItem = try NSKeyedUnarchiver.unarchiveObject(withFile: randomFileName) {
                savedItem = [loadItem]
            }
        }catch {
           print("Couldn't find file")
        }
 */
        
        
    }
    
    
//ReactionFuntion#############################################################################################################################ReactionFuntion
//ReactionFuntion#############################################################################################################################ReactionFuntion
    //TouchDetection//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////TouchDetection
        //DragDetetion------------------------------------------------------------------------------------------------------------------DragDetetion
    @IBAction func Pan(_ sender: UIPanGestureRecognizer) {
        //Pan detection help: https://www.raywenderlich.com/433-uigesturerecognizer-tutorial-getting-started
        let translation = sender.translation(in: self.view)
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
      
        if items.count > 0{
            //DragSelection......................................................................................................DragSelection
            for i in stride(from:items.count-1, to: -1, by:-1 ){
                if sender.state == .began {
                    if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{items[i].select = true}
                    if items[i].select == true{
                        break
                    }else if i == items.count-1{
                        scrollView.isScrollEnabled = true
                    }
                }
            }
            
            //Draging..................................................................................................................Draging
            for i in 0...items.count-1{
                if items[i].select == true {
                    if sender.state == .changed {
                        FillProprties(info: items[i])
                        let newX = items[i].x+Int(Float(translation.x)*Float(1/aspect))
                        let newY = items[i].y+Int(Float(translation.y)*Float(1/aspect))
                        xPosInfoBox.text = String(newX)
                        yPosInfoBox.text = String(Int(MyView.frame.height)-((newY)+(items[i].height+20)))
                        
                        items[i].updateImage(xPos: newX, yPos: newY)
                    }
                    if sender.state == .ended {
                        //items[i].select = false
                        items[i].x = items[i].x+Int(Float(translation.x)*Float(1/aspect))
                        items[i].y = items[i].y+Int(Float(translation.y)*Float(1/aspect))
                        items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                    }
                }
            }
        }else{
            scrollView.isScrollEnabled = true
        }
    }
    
        //TapDetection------------------------------------------------------------------------------------------------------------------TapDetection
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        /* Tap detection help: https://stackoverflow.com/questions/45629639/calling-function-when-user-taps-anywhere-on-screen */
        
        //
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        
        if CurserButton.isSelected == false{
            for i in 0...items.count-1{
                items[i].select = false
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        
        if items.count > 0{
            addAni.backgroundColor = UIColor.white
            //newItemTapped?
            for i in stride(from:items.count-1, to: -1, by:-1 ){
                if items[i].select == false{
                    if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{
                        items[i].select = true
                    }
                    if items[i].select == true{
                        scrollView.isScrollEnabled = false
                        items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                        FillProprties(info: items[i])
                        break
                    }
                }
            }
            
            //AnythingTapped?
            for i in stride(from:items.count-1, to: -1, by:-1 ){
                if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{
                    //does an animation need to be swiched?
                    if animations.count > 0{
                        for j in 0...animations.count-1{
                            if animations[j].newItem == true{
                                animations[j].identity = items[i]
                                animations[j].newItem = false
                            }
                        }
                    }
                    break
                }else if i == 0{//unselect all
                    scrollView.isScrollEnabled = true
                    for k in 0...items.count-1{
                        items[k].select = false
                        items[k].updateImage(xPos: items[k].x, yPos: items[k].y)
                    }
                    EmptyProprties()
                    addAni.backgroundColor = UIColor.gray
                }
            }
        }else{//if there are no items
            scrollView.isScrollEnabled = true
        }
        
        //animation tap detection
        if animations.count>0{
            if  aniMenu.isHidden == false { //is the menu even open?
                for i in 0...animations.count-1{
                    if animations[i].tapPos == true{//re define animation coordinates
                        animations[i].x = Int(sender.location(in: BackgroundImage).x)
                        animations[i].y = Int(sender.location(in: BackgroundImage).y)
                        animations[i].tapPos = false
                        animations[i].identity.select = true
                        animations[i].identity.updateImage(xPos: animations[i].identity.x, yPos: animations[i].identity.y)
                        addAni.backgroundColor = UIColor.white
                    }
                    //tapped inside animation
                    if animations[i].tapped(x: Int(sender.location(in: aniScrollView).x),y: Int(sender.location(in: aniScrollView).y)){
                        animations[i].open = true
                        //tapped "with"/"after"
                        if animations[i].tappedActivation(x: Int(sender.location(in: animations[i].box).x),
                                                          y: Int(sender.location(in: animations[i].box).y))&&animations[i].open == true{
                            animations[i].switchType()
                            break
                        }
                        //tapped the up button
                        else if animations[i].TapUp(x: Int(sender.location(in: animations[i].box).x),
                                                               y: Int(sender.location(in: animations[i].box).y))&&i>0{
                            animations.swapAt(i, i-1)
                            break
                        }
                        //tapped the down button
                        else if animations[i].TapDown(x: Int(sender.location(in: animations[i].box).x),
                                                               y: Int(sender.location(in: animations[i].box).y))&&i<animations.count-1{
                            animations.swapAt(i, i+1)
                            break
                        }
                        //tapped the delete button
                        else if animations[i].TapOut(x: Int(sender.location(in: animations[i].box).x),
                                                      y: Int(sender.location(in: animations[i].box).y)){
                            animations[i].view.removeFromSuperview()
                            animations.remove(at: i)
                            break
                        }
                    }else{
                        animations[i].open = false
                    }
                }
                UpdateAnimationMenu()
            }
        }
    }
    //Buttons////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Buttons
    
    
    
    @IBAction func mutiSelect(_ sender: Any) {
        if CurserButton.isSelected == true {
            CurserButton.isSelected = false
            CurserButton.backgroundColor = UIColor.white
        }else{
            CurserButton.isSelected = true
            CurserButton.backgroundColor = UIColor.gray
        }
    }
    
        //Actor_Button------------------------------------------------------------------------------------------------------------------Actor_Button
    @IBAction func addActor(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                          y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                          width: 30,
                          height: 25,
                          angle : 0,
                          name: "Unnamed Actor",
                          type: "Actor Shape")!)
        BackgroundImage.addSubview(items[items.count-1].sv)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
        //Set_Button----------------------------------------------------------------------------------------------------------------------Set_Button
    @IBAction func AddSet(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                          y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                          width: 50,
                          height: 30,
                          angle : 0,
                          name: "Unnamed Set piece",
                          type: "Set Shapes")!)
        BackgroundImage.addSubview(items[items.count-1].sv)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
        //Arrow_Button------------------------------------------------------------------------------------------------------------------Arrow_Button
    @IBAction func MenuShift(_ sender: Any) {
        if MenuView.isHidden == true{
            self.MenuView.frame.origin.y = -self.MenuView.frame.height
            self.MenuView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.MenuView.frame.origin.y = 20
                self.MenuButton.frame.origin.y = self.MenuView.frame.height+20
                self.MenuButton.transform = CGAffineTransform(rotationAngle:0)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.MenuView.isHidden = true
                self.PropertyMenuView.isHidden = true
                self.aniMenu.isHidden = true
            }
            UIView.animate(withDuration: 0.5) {
                self.MenuView.frame.origin.y = -self.MenuView.frame.height
                self.MenuButton.frame.origin.y = 0
                self.MenuButton.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
                self.aniMenu.frame.origin.x = self.MyView.frame.width
            }
        }
    }
        //Colour_Button----------------------------------------------------------------------------------------------------------------Colour_Button
    @IBAction func PropertiesMenu(_ sender: Any) {
        if aniMenu.isHidden == false{
            self.Animate((Any).self)
        }
        if PropertyMenuView.isHidden == true {
            self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            PropertyMenuView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width-self.PropertyMenuView.frame.width
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.PropertyMenuView.isHidden = true
            }
        }
    }
    
        //trash_Button------------------------------------------------------------------------------------------------------------------trash_Button
    @IBAction func deletActor(_ sender: Any) {//self explanitory
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    if animations.count>0{
                        for j in stride(from:animations.count-1, to: -1, by:-1 ){
                            if animations[j].identity == items[i]{
                                animations[j].box.removeFromSuperview()
                                animations.remove(at: j)
                            }
                        }
                        UpdateAnimationMenu()
                    }
                    items[i].imageView.removeFromSuperview()
                    items.remove(at: i)
                    EmptyProprties()
                    break
                }
            }
        }
    }
    
        //Rotate_Button----------------------------------------------------------------------------------------------------------------Rotate_Button
    @IBAction func rotatePress(_ sender: Any) {
        if items.count > 0 {
            for i in 0...items.count-1 {
                if items[i].select == true {
                    items[i].angle += 1/6 * .pi
                    items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                }
            }
        }
    }
        //Animate_Button--------------------------------------------------------------------------------------------------------------Animate_Button
    @IBAction func Animate(_ sender: Any) {
        if PropertyMenuView.isHidden == false{
            self.PropertiesMenu((Any).self)
        }
        if aniMenu.isHidden == true {
            UpdateAnimationMenu()
            self.aniMenu.frame.origin.x = self.MyView.frame.width
            aniMenu.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.aniMenu.frame.origin.x = self.MyView.frame.width-self.aniMenu.frame.width
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.aniMenu.frame.origin.x = self.MyView.frame.width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.aniMenu.isHidden = true
            }
        }
    }
    //Play_Button-----------------------------------------------------------------------------------------------------------------------------Play_Button
    @IBAction func playAnimation(_ sender: Any) {
        if animations.count > 0{
            if animating == false{
                animating = true
                AnimateList(loop:aniStep,end:animations.count)
            }
        }
    }
    
    //Item_properties---------------------------------------------------------------------------------------------------------------------Item_properties
        //Height..............................................................................................................................Height
    @IBAction func heightItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].height = abs(Int(heightInfoBox.text!) ?? 0)
                }
            }
        }
    }
    //Width................................................................................................................................Width
    @IBAction func widthItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].width = abs(Int(widthInfoBox.text!) ?? 0)
                }
            }
        }
    }
    //Y_position.......................................................................................................................Y_position
    @IBAction func YposItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].y = Int(MyView.frame.height)-((Int(yPosInfoBox.text!) ?? 0)+(items[i].height+20))
                }
            }
        }
    }
    //X_position.......................................................................................................................X_position
    @IBAction func xPosItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].x = Int(xPosInfoBox.text!) ?? 0
                }
            }
        }
    }
    //Name..................................................................................................................................Name
    @IBAction func NameItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].name = nameInfoBox.text!
                }
            }
        }
    }
    @IBAction func angleItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].angle = CGFloat(Int(angleInfoBox.text!) ?? 0) / 57.2958
                }
            }
        }
    }
    //Colour..............................................................................................................................Colour
    @IBAction func Colour1(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(050)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 1{red = CGFloat(100)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 2{red = CGFloat(100)/CGFloat(100); green = CGFloat(049)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 3{red = CGFloat(100)/CGFloat(100); green = CGFloat(099)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour2(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(050)/CGFloat(100); blue = CGFloat(001)/CGFloat(100)}
        if num == 1{red = CGFloat(000)/CGFloat(100); green = CGFloat(100)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 2{red = CGFloat(000)/CGFloat(100); green = CGFloat(100)/CGFloat(100); blue = CGFloat(098)/CGFloat(100)}
        if num == 3{red = CGFloat(020)/CGFloat(100); green = CGFloat(050)/CGFloat(100); blue = CGFloat(099)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectOne.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour3(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(050)/CGFloat(100)}
        if num == 1{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        if num == 2{red = CGFloat(049)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        if num == 3{red = CGFloat(099)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectOne.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour4(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 1{red = CGFloat(060)/CGFloat(100); green = CGFloat(060)/CGFloat(100); blue = CGFloat(060)/CGFloat(100)}
        if num == 2{red = CGFloat(099)/CGFloat(100); green = CGFloat(099)/CGFloat(100); blue = CGFloat(099)/CGFloat(100)}
        if num == 3{red = CGFloat(060)/CGFloat(100); green = CGFloat(040)/CGFloat(100); blue = CGFloat(020)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectOne.selectedSegmentIndex = -1
    }
    
    @IBAction func AddAni(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true {
                    animations.append(Animator(x: Int(MyView.frame.width/2), y: Int(MyView.frame.height/2),
                                               time: 1, identity: items[i],type: false, screen: MyView,simple: false)!)
                    for i in 0...animations.count-1{
                        animations[i].open = false
                    }
                    animations[animations.count-1].open = true
                }
            }
        }
        UpdateAnimationMenu()
    }
    
    @IBAction func AddLight(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                          y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                          width: 150,
                          height: 125,
                          angle : 0,
                          name: "Unnamed light",
                          type: "Light Circle")!)
        BackgroundImage.addSubview(items[items.count-1].sv)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
    @IBAction func addProp(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                          y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                          width: 10,
                          height: 10,
                          angle : 0,
                          name: "Unnamed Prop",
                          type: "Prop Shape Tool")!)
        BackgroundImage.addSubview(items[items.count-1].sv)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
    @IBAction func addCurtainAni(_ sender: Any) {
        animations.append(Animator(x: 0, y: 0, time: 1, identity: items[0], type: false, screen: MyView, simple: true)!)
        animations[animations.count-1].open = true
        UpdateAnimationMenu()
    }
    @IBAction func stopAnimation(_ sender: Any) {
        animating = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animations[aniStep].time) {
            self.aniStep = 0
        }
    }
    @IBAction func pauseAnimation(_ sender: Any) {
        animating = false
    }
    //Funtions//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Funtions
    
    func drawArrow(ani: Int){
        let x = Float(animations[ani].x)
        let y = Float(animations[ani].y)
        var preX = Float(0.0)
        var preY = Float(0.0)
        
        for i in 0...animations.count-1{
            if  i == animations.count-1{
                preX = Float(animations[ani].identity.x)
                preY = Float(animations[ani].identity.y)
                break
            }
            if animations[ani].identity == animations[ani-i].identity{
                preX = Float(animations[(ani-i)].x)
                preY = Float(animations[(ani-i)].y)
                break
            }
            if i == animations.count-1{
                preX = Float(animations[ani].identity.x)
                preY = Float(animations[ani].identity.y)
                break
            }
        }
        var adj = Int(preX-x)
        var opp = Int(preY-y)
        opp = Int(pow(Double(opp),2))
        adj = Int(pow(Double(adj),2))
        var tot = Float(opp+adj)
        tot = tot.squareRoot()
        
        if adj != 0{
            print("draw")
            arrow = UIImageView.init(image: UIImage(named: "Arrow"))
            arrow.frame = CGRect(x: 0, y: 0, width: 20, height: Int(tot))
            var rot = CGFloat(atan(Double((preY-y)/(preX-x))))
            if preX >= x {rot += CGFloat.pi/2}else{rot -= CGFloat.pi/2}
            arrowRot.transform = CGAffineTransform(rotationAngle: rot)
            arrowRot.frame = CGRect(x: Int(preX), y: Int(preY), width: 0, height: 0)
            arrowRot.addSubview(arrow)
            arrowRot.removeFromSuperview()
            BackgroundImage.addSubview(arrowRot)
        }
    }
    
        //FillAnimationMenu------------------------------------------------------------------------------------------------------FillAnimationMenu
    func UpdateAnimationMenu(){
        var check = false
        var space = 0
        
        if aniScrollView.subviews.count > 2 {
            for i in 0...animations.count-1{
                animations[i].view.removeFromSuperview()
            }
        }
        
        if animations.count > 0 {
            for i in 0...animations.count-1{
                if animations[i].simple == true{
                    space = animations[i].drawSimple(num: space)
                }else{
                    if animations[i].open == true{
                        arrow.removeFromSuperview()
                        arrowRot.removeFromSuperview()
                        space = animations[i].drawOpen(num: space)
                        drawArrow(ani: i)
                        check = true
                    }else{
                        space = animations[i].drawClose(num: space)
                        if check == false{
                            arrow.removeFromSuperview()
                            arrowRot.removeFromSuperview()
                        }
                    }
                }
                aniScrollView.addSubview(animations[i].view)
            }
        }
        aniHeight.constant = CGFloat(space)-aniScroll.frame.height+75
        aniScrollView.updateConstraints()
    }
        //EmptyPropMenu--------------------------------------------------------------------------------------------------------------EmptyPropMenu
    func EmptyProprties(){
        nameInfoBox.text = nil
        xPosInfoBox.text = nil
        yPosInfoBox.text = nil
        widthInfoBox.text = nil
        heightInfoBox.text = nil
        angleInfoBox.text = nil
        for i in 0...c.count-1{
            c[i].tintColor = UIColor.init(red:0, green:0, blue:0, alpha:1)
            c[i].selectedSegmentIndex = -1
            c[i].isEnabled = false
        }
    }
        //FillPropMenu----------------------------------------------------------------------------------------------------------------FillPropMenu
    func FillProprties(info: Item){
        nameInfoBox.text = info.name
        xPosInfoBox.text = String(info.x)
        yPosInfoBox.text = String((Int(MyView.frame.height)-info.y)-(info.height+20))
        widthInfoBox.text = String(info.width)
        heightInfoBox.text = String(info.height)
        angleInfoBox.text = String(Int(info.angle*57.2958))
        for i in 0...c.count-1{c[i].tintColor = info.colour; c[i].isEnabled = true}
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        info.colour.getRed(&r, green: &g, blue: &b, alpha: &a)
              if r == 1 || r == 0.5 {
                     if r == 0.50 {c[0].selectedSegmentIndex = 0}
                else if g == 0.00 {c[0].selectedSegmentIndex = 1}
                else if g == 0.49 {c[0].selectedSegmentIndex = 2}
                else              {c[0].selectedSegmentIndex = 3}
        }else if g == 1 || g == 0.5 {
                     if b == 0.01 {c[1].selectedSegmentIndex = 0}
                else if b == 0.00 {c[1].selectedSegmentIndex = 1}
                else if b == 0.98 {c[1].selectedSegmentIndex = 2}
                else              {c[1].selectedSegmentIndex = 3}
        }else if b == 1 || b == 0.5 {
                     if b == 0.50 {c[2].selectedSegmentIndex = 0}
                else if r == 0.00 {c[2].selectedSegmentIndex = 1}
                else if r == 0.49 {c[2].selectedSegmentIndex = 2}
                else              {c[2].selectedSegmentIndex = 3}
        }else                       {
                     if b == 0.00 {c[3].selectedSegmentIndex = 0}
                else if b == 0.60 {c[3].selectedSegmentIndex = 1}
                else if b == 0.99 {c[3].selectedSegmentIndex = 2}
                else              {c[3].selectedSegmentIndex = 3}
        }
    }
        //AnimationManeger----------------------------------------------------------------------------------------------------------AnimationManeger
    func AnimateList(loop: Int,end: Int){
        var numTogether = 0
        var time = 0.0
        if loop < end-1{
            for i in loop...animations.count-2{
                if animations[i+1].type == true && i<animations.count-1 {
                    numTogether+=1
                }else{break}
            }
        }
        for j in 0...numTogether{
            
            if animations[loop+j].time > time {
                time = animations[loop+j].time
            }
            
            animations[loop+j].view.backgroundColor = UIColor.green
            
            UIView.animate(withDuration: animations[loop+j].time) {
                if self.animations[loop+j].simple == true{
                    self.c1.frame = CGRect(x: self.c1.frame.origin.x, y: self.c1.frame.origin.y,
                                           width: CGFloat(self.animations[loop+j].percent*(225/100)), height: self.c1.frame.height)
                    self.c2.frame = CGRect(x: self.c1.frame.origin.x, y: self.c1.frame.origin.y,
                                           width: CGFloat(self.animations[loop+j].percent*(190/100)), height: self.c1.frame.height)
                }else{
                    self.animations[loop+j].identity.x = self.animations[loop+j].x
                    self.animations[loop+j].identity.y = self.animations[loop+j].y
                    self.animations[loop+j].identity.updateImage(xPos: self.animations[loop+j].identity.x,
                                                                 yPos: self.animations[loop+j].identity.y)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            for j in 0...numTogether{
                if loop+numTogether<end{
                    self.animations[loop+j].view.backgroundColor = UIColor.white
                }
            }
            numTogether+=1
            if loop+numTogether<end{
                if self.animating{
                    self.AnimateList(loop: loop+numTogether, end: end)
                }else{
                    self.aniStep = loop+numTogether
                }
            }else{
                self.aniStep = 0
                self.animating = false
            }
        }
    }
        //ZoomingManeger--------------------------------------------------------------------------------------------------------------ZoomingManeger
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // Zooming tutorial: https://www.youtube.com/watch?v=TEBDwYkYx00
        return self.BackgroundImage
    }
}


//Extentions+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Extentions
    //ScrollViewImagePosition----------------------------------------------------------------------------------------------------ScrollViewImagePosition
extension UIView {
    //taken from: https://medium.com/@joesusnick/a-uiview-extension-that-will-teach-you-an-important-lesson-about-frames-cefe1e4beb0b
    func positionIn(view: UIView) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}
    //TouchScreenDelegation--------------------------------------------------------------------------------------------------------TouchScreenDelegation
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ViewController {
    func test() {
        UpdateAnimationMenu()
    }
}

