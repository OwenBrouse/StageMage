//
//  HelpViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2019-01-15.
//  Copyright © 2019 KingByngInc. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var buttons: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonpress(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            textBox.text = "Save\nLets you save a project of your set up.\n\nLoad\nLets you open a saved project.\n\nActor\nWhen tapped, adds an actor to the middle of the floor plan.\n\nSet\nWhen tapped, adds an set piece to the middle of the floor plan.\n\nprop\nWhen tapped, adds an prop to the middle of the floor plan.\n\nAnimation\nOpens a menu that allows simple animations of any item. It also allows the opening and closing of the curtains.\n\nLights\nWhen tapped, adds an spotlight to the middle of the floor plan\n\nDelete\nRemoves a selected object.\n\nRotate\nRotates selected object by 30 degrees.\n\nMulti-Select\nWhen active this will allow you to select multiple objects at the same time. If something is selected, a red box will appear around it. Any changes you do in the properties menu, will affect all objects that are selected. Movement made on the screen (not typed in properties menu), will have the objects move from their starting position."
        }
        if sender.selectedSegmentIndex == 1{
            textBox.text = "These properties when tapped on the text box, allow you to type in whatever you choose.\n\nName: Allows you to give the object a name.\nX: The x coordinate of the object.\nY: The y coordinate of the object.\nAngle (∠): The rotation of the object.\nL: The length of the object.\nW: The width of the object.\nColor: Tap on the options to change the color of the object."
        }
        if sender.selectedSegmentIndex == 2{
            textBox.text = "Play\nPlays the animations in order.\n\nPause\nStop the animations from proceeding, pressing play will resume from where it left off.\n\nStop\nStop the animations from proceeding, pressing play will resume from the beginning"
        }
        if sender.selectedSegmentIndex == 3{
            textBox.text = "Adds an animation box for the curtains.\n\nDur\nDefines how long the animation will take.\n\n%\nTo what percentage the curtains will be closed (100% = fully closed, 0% = Fully open).\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation"
        }
        if sender.selectedSegmentIndex == 4{
            textBox.text = "A closed animation box will be the most common one you can see. On it, there will be the name of the item being animated, the destination of the animation (in x,y coordinates), the duration of the animation and the text “with prev” or “after prev”.\n\n\nName box\nWhen tapped, it turns red. Once red, the next object tapped will take ownership of the of  animation.\n\nX\nChanges the horizontal destination.\n\nY\nChanges the vertical destination.\n\nDur\nDefines how long the animation will take.\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation."
        }
        if sender.selectedSegmentIndex == 5{
            textBox.text = "A open animation box will be larger that normal and have more information. On it, there will be the name of the item being animated the destination of the animation (in x,y coordinates), the duration of the animation, the text “with prev” or “after prev”, three box at the bottom that say “before” “after” “delete” and one that says “set destination”.\n\n\nName box\nWhen tapped, it turns red. Once red, the next object tapped will take ownership of the of  animation.\n\nX\nChanges the horizontal destination.\n\nY\nChanges the vertical destination.\n\nDur\nDefines how long the animation will take.\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation.\n\nBefore\nMoves the animation forward in the order of animations que.\n\nAfter\nMoves the animation backwards in the order of animations que.\n\nDelete\nRemoves the animation.\n\nSet destination\nWhen tapped turns red, once red the next place tapped will become the new destination of the animation."
        }
        if sender.selectedSegmentIndex == 6{
            textBox.text = "1) Zoom in to make objects easier to tap.\n2) Select multiple objects when working with many objects at once."
        }
    }
    
    
}






    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

