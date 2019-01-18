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
    }
    
    @IBAction func buttonpress(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{ //Menu Buttons
            textBox.text = "Save\nLets you save a project of your set up.\n\nLoad\nLets you open a saved project.\n\nMulti-Select\nWhen active this will allow you to select multiple objects at the same time. If something is selected, a red box will appear around it. Any changes you do in the properties menu, will affect all objects that are selected.\n\nRotate\nRotates selected object by 30 degrees.\n\nActor\nWhen tapped, adds an actor to the middle of the floor plan.\n\nSet\nWhen tapped, adds an set piece to the middle of the floor plan.\n\nProp\nWhen tapped, adds an prop to the middle of the floor plan.\n\nLights\nWhen tapped, adds an spotlight to the middle of the floor plan\n\nAnimation\nOpens a menu that allows simple animations of any item. It also allows the opening and closing of the curtains\n\nProperties\nOpens a menu that lets you ajust how an item looks\n\nhelp\nThis page.\n\nDelete\nRemoves a selected object."
        }
        if sender.selectedSegmentIndex == 1{ //Properties Menu
            textBox.text = "These properties when tapped on the text box, allow you to type in whatever you choose.\n\nName: Allows you to give the object a name.\nX: The x coordinate of the object.\nY: The y coordinate of the object.\nAngle (∠): The rotation of the object.\nL: The length of the object.\nW: The width of the object.\nColor: Tap on the options to change the color of the object."
        }
        if sender.selectedSegmentIndex == 2{ //Play/pause/stop
            textBox.text = "The play, pause and stop buttons can be found in the animation menu at the bottom\n\n\nPlay\nPlays the animations in order.\n\nPause\nStop the animations from proceeding, pressing play will resume from where it left off.\n\nStop\nStop the animations from proceeding, pressing play will resume from the beginning"
        }
        if sender.selectedSegmentIndex == 3{ // add curtains
            textBox.text = "The \"add curtains\" button can be found in the animation menu at the bottom of the animations beside the \"add animation\" button. it Adds an animation box for the curtains.\n\nDur\nDefines how long the animation will take.\n\n%\nTo what percentage the curtains will be closed (100% = fully closed, 0% = Fully open).\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation"
        }
        if sender.selectedSegmentIndex == 4{ // animation Information
            textBox.text = "A closed animation box will be the most common one you can see. On it, there will be the name of the item being animated, the destination of the animation (in x,y coordinates), the duration of the animation and the text “with prev” or “after prev”. It can be seen after creating a new animation with an item selected\n\n\nName box\nWhen tapped, it turns red. Once red, the next object tapped will take ownership of the of  animation.\n\nX\nChanges the horizontal destination.\n\nY\nChanges the vertical destination.\n\nDur\nDefines how long the animation will take.\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation."
        }
        if sender.selectedSegmentIndex == 5{ //Animation Editing
            textBox.text = "A open animation box will be larger that normal and have more information. On it, there will be the name of the item being animated the destination of the animation (in x,y coordinates), the duration of the animation, the text “with prev” or “after prev”, three box at the bottom that say “before” “after” “delete” and one that says “set destination”. It can be seen when a new animation is created or when a closed animation is tapped\n\n\nName box\nWhen tapped, it turns red. Once red, the next object tapped will take ownership of the of  animation.\n\nX\nChanges the horizontal destination.\n\nY\nChanges the vertical destination.\n\nDur\nDefines how long the animation will take.\n\nWith Prev / after Prev\nDescribes if the animation will happen at the same time / after the preceding animation.\n\nBefore\nMoves the animation forward in the order of animations que.\n\nAfter\nMoves the animation backwards in the order of animations que.\n\nDelete\nRemoves the animation.\n\nSet destination\nWhen tapped turns red, once red the next place tapped will become the new destination of the animation."
        }
        if sender.selectedSegmentIndex == 6{ //Quick tips
            textBox.text = "1) Zoom in to make objects easier to tap.\n2) Select multiple objects when working with many objects at once.\n3) Create a 0 second animation at the begining to make a starting point for an item"
        }
    }
}
