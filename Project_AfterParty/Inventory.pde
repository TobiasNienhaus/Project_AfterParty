
public class Inventory
{
  // This class is for an Item that can be displayed in the inventory bar
  class InventoryItem
  {
    // The item stored in the inventory
    Item item;
    // The rect of the item slot (for mouse collision)
    Rect rect;
    
    // Constructor: set item and rect
    public InventoryItem(Item item, Rect rect)
    {
      this.item = item;
      this.rect = rect;
    }
    
    // display everything
    void display()
    {
      rect.display();
      item.display();
    }
    
    // call to update position of item to reflect position of rect
    void updatePos()
    {
      item.setPos(rect.x,rect.y);
    }
    
    // call to update size of item to reflect size of item
    void updateSize()
    {
      item.setSize(rect.w, rect.h);
    }
    
    // the type of the stored item
    ItemType type() { return item.getType(); }
  }
  
  // The Inventory slots
  InventoryItem[] items;
  // The size of the inventory
  int invSize = 6;
  
  // Constructor
  public Inventory()
  {
    //create new array for inventory slots
    items = new InventoryItem[invSize];
    
    //set rectSize and spacing inbetween
    float rectSize = 150f;
    float rectSpace = 40f;
    //calculate xOff (left border of inventory display)
    float xOff = -(items.length*rectSize+(items.length-1)*rectSpace)/2f;
    
    for(int i = 0; i < items.length; i++)
    {
      // calculate x and y of each inventory item/slot
      float xPos = (width/2f+xOff)+(i*(rectSize+rectSpace));
      float yPos = height-rectSize-rectSpace;
      
      // fill inventory with items
      Item item = new EmptyItem();
      // create rect for each inventory slot
      Rect r = new Rect(xPos, yPos, rectSize, rectSize);
      // create new InventoryItems
      items[i] = new InventoryItem(item, r);
    }
  }
  
  // Add an already existing item
  public boolean AddItem(Item item)
  {
    int index = findFirstEmpty();
    if(index == -1)
      return false;
    items[index].item = item;
    return true;
  }
  
  // Add an item based on an ItemType
  public boolean AddItem(ItemType type)
  {
    int index = findFirstEmpty();
    if(index == -1) return false;
    Item item = createItemFromType(type);
    items[index].item = item;
    items[index].updatePos();
    items[index].updateSize();
    return true;
  }
  
  // delete an item from the inventory by index
  public void deleteItem(int index)
  {
    if(index > items.length || index < 0)
      return;
    items[index].item = new EmptyItem();
  }
  
  //find the first empty slot in the inventory
  int findFirstEmpty()
  {
    for(int i = 0; i < items.length; i++)
    {
      if(items[i].item.getType() == ItemType.Empty)
        return i;
    }
    return -1;
  }
  
  // combine two items
  void CombineItems(Item i1, Item i2)
  {
    // try to combine the two items
    Item res = i1.Combine(i2);
    // if the combination is not valid, return
    if(res.getType() == ItemType.Error || res.getType() == ItemType.Empty)
      return;
    // get indices of the two old items
    int index1 = getIndex(i1);
    int index2 = getIndex(i2);
    
    // check if both indices are valid, if not return
    if(index1 < 0 || index1 > items.length)
      return;
    if(index2 < 0 || index2 > items.length)
      return;
    
    // set combined item to slot of first item
    items[index1].item = res;
    // delete the other item
    deleteItem(index2);
    // reorder the array
    reorderArray();
  }
  
  // reorder the array, that empty slots are in the end
  void reorderArray()
  {
    //number of slots in the inventory, that are not empty
    int itemCount = 0;
    //iterate through all items
    for(int i = 0; i < items.length; i++)
    {
      ItemType t = items[i].type();
      if(!(t == ItemType.Error || t == ItemType.Empty))
      {
        // if the item is valid, increment the item count
        itemCount++;
      }
    }
    
    // create a new array with the length of the non empty inventory slots
    Item[] temp = new Item[itemCount];
    
    // put the non empty elements of the inventory array into the temp array
    int tempIndex = 0;
    for(int i = 0; i < items.length; i++)
    {
      ItemType t = items[i].type();
      if(!(t == ItemType.Error || t == ItemType.Empty))
      {
        temp[tempIndex] = items[i].item;
        tempIndex++;
      }
    }
    
    // put the items from the temp array into the beginning of the item array and fill the rest wih empties
    for(int i = 0; i < items.length; i++)
    {
      if(i < temp.length)
      {
        items[i].item = temp[i];
        items[i].updatePos();
      }
      else items[i].item = new EmptyItem();
    }
  }
  
  // get the index of an existing item in the array
  int getIndex(Item i)
  {
    for(int j = 0; j < items.length; j++)
    {
      if(items[j].item == i)
        return j;
    }
    return -1;
  }
  
  // The item that is currently being dragged
  Item draggedItem;
  // the index of the item, that is currently being dragged
  int draggedIndex = -1;
  
  // called on Mouse Press, returns true if the press is valid, so the collision for
  // other objects can be blocked
  boolean onMousePress()
  {
    boolean res = false;
    for(int i = 0; i < items.length; i++)
    {
      if(MouseInRect(items[i].rect))
      {
        // if the press is valid, copy the item under the mouse
        draggedItem = createItemFromType(items[i].item);
        draggedIndex = i;
        res = true;
      }
    }
    return res;
  }
  
  boolean onMouseRelease()
  {
    if(draggedItem == null || draggedIndex == -1) return false;
    //get item thats dropped on
    boolean res = false;
    for(int i = 0; i < items.length; i++)
    {
      // get the item thats under the mouse
      if(MouseInRect(items[i].rect))
      {
        // try to combine the items (the one that's dragged and the one thats under the mouse)
        CombineItems(items[draggedIndex].item, items[i].item);
        res = true;
      } 
    }
    // if there is no item under the mouse, check if it is being dropped on an object in the scene
    if(!res)
    {
      if(gameHandler.dropItem(draggedItem))
      {
        deleteItem(draggedIndex);
        reorderArray();
        res = true;
      }
    }
    
    // mouse was released so reset the dragged item
    draggedItem = null;
    draggedIndex = -1;
    return res;
  }
  
  void display()
  {
    for(int i = 0; i < items.length; i++)
      items[i].display();
    
    if(draggedItem != null)
    {
      draggedItem.setPos(mouseX,mouseY);
      draggedItem.display();
    }
    
    pushMatrix();
    textSize(64);
    fill(0);
    textAlign(LEFT, TOP);
    text("Bottles: " + bottleCount + "/" + maxBottleCount, 25, 25);
    popMatrix();
  }
  
  int bottleCount = 0;
  int maxBottleCount = 6;
  
  void collectBottle()
  {
    bottleCount++;
    if(bottleCount == 1)
      gameHandler.dHandler.startDialogue(dialogues.bottle1,null);
    else if(bottleCount == 2)
      gameHandler.dHandler.startDialogue(dialogues.bottle2,null);
    else if(bottleCount == 3)
      gameHandler.dHandler.startDialogue(dialogues.bottle3,null);
    else if(bottleCount == 4)
      gameHandler.dHandler.startDialogue(dialogues.bottle4,null);
    else if(bottleCount == 5)
      gameHandler.dHandler.startDialogue(dialogues.bottle5,null);
    else if(bottleCount == 6)
    {
      gameHandler.dHandler.startDialogue(dialogues.bottle6,null);
      gameHandler.tHandler.finishTask();
    }
  }
}
