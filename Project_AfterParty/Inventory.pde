// Inventory structure

// have an array of slots
// have an amount of clickable things in the bottom

// drag and drop
//    have a function to combine two objects
//  Inventory has callback for mousePressed and mouseReleased
//  Have a dragged object that follows the mouse
//      is updated when pressing mouse
//      is updated when releasing mouse (checking for possible combination when dropped on other)

/* Pseudo Code
class Inventory
{
  constructor();
  
  Array items = Array[6];
  
  // dragging and dropping
  addItem(Item item)
  {
    int i = findFirstEmpty();
    if(i == -1)
      return;
    items[i] = item;
  }
  
  number findFirstEmpty()
  {
    for(int i = 0; i < items.length; i++)
    {
      if(items[i] == null)
        return i;
    }
    return -1;
  }
  
  Item dragged;
  
  mousePressed()
  {
    //check for item under mouse
    dragged = itemUnderMouse;
  }
  
  mouseReleased()
  {
    //check if dragged exists
    //check if there is another item below mouse
    
    //check if there is anything else below mouse (character)
  } 
  
  combineItems(item1, item2)
  {
    //try to combine items
  }
}
*/
