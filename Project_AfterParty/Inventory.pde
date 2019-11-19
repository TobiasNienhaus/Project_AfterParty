// Inventory structure

// have an array of slots
// have an amount of clickable things in the bottom

// drag and drop
//    have a function to combine two objects
//  Inventory has callback for mousePressed and mouseReleased
//  Have a dragged object that follows the mouse
//      is updated when pressing mouse
//      is updated when releasing mouse (checking for possible combination when dropped on other)

public class Inventory
{
  class InventoryItem
  {
    Item item;
    Rect rect;
    
    public InventoryItem(Item item, Rect rect)
    {
      this.item = item;
      this.rect = rect;
    }
    
    void display()
    {
      rect.debugDisplay();
      item.display();
    }
    
    void updatePos()
    {
      item.setPos(rect.x,rect.y);
    }
    
    ItemType type() { return item.getType(); }
  }
  
  InventoryItem[] items;
  
  int invSize = 8;
  
  public Inventory()
  {
    items = new InventoryItem[invSize];
    
    float rectSize = 150f;
    float rectSpace = 40f;
    float xOff = -(items.length*rectSize+(items.length-1)*rectSpace)/2f;
    
    for(int i = 0; i < items.length; i++)
    {
      float xPos = (width/2f+xOff)+(i*(rectSize+rectSpace));
      float yPos = height-rectSize-rectSpace;
      
      Item item = random(1f) < 0.5f ? 
        new TestItem1(xPos, yPos, rectSize, rectSize) :
        new TestItem2(xPos, yPos, rectSize, rectSize);
      Rect r = new Rect(xPos, yPos, rectSize, rectSize);
      items[i] = new InventoryItem(item, r);
    }
  }
  
  public void AddItem(Item item)
  {
    int index = findFirstEmpty();
    if(index == -1)
      return;
    items[index].item = item;
  }
  
  public void deleteItem(int index)
  {
    if(index > items.length || index < 0)
      return;
    items[index].item = new EmptyItem();
  }
  
  int findFirstEmpty()
  {
    for(int i = 0; i < items.length; i++)
    {
      if(items[i].item.getType() == ItemType.Empty)
        return i;
    }
    return -1;
  }
  
  void CombineItems(Item i1, Item i2)
  {
    Item res = i1.Combine(i2);
    if(res.getType() == ItemType.Error || res.getType() == ItemType.Empty)
      return;
    int index1 = getIndex(i1);
    int index2 = getIndex(i2);
    
    if(index1 < 0 || index1 > items.length)
      return;
    if(index2 < 0 || index2 > items.length)
      return;
      
    items[index1].item = res;
    deleteItem(index2);
    
    reorderArray();
  }
  
  void reorderArray()
  {
    //number of items in the inventory
    int itemCount = 0;
    for(int i = 0; i < items.length; i++)
    {
      ItemType t = items[i].type();
      if(!(t == ItemType.Error || t == ItemType.Empty))
      {
        // if the item is valid, increment the item count
        itemCount++;
      }
    }
    
    Item[] temp = new Item[itemCount];
    
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
  
  int getIndex(Item i)
  {
    for(int j = 0; j < items.length; j++)
    {
      if(items[j].item == i)
        return j;
    }
    return -1;
  }
  
  Item draggedItem;
  int draggedIndex = -1;
  
  void onMousePress()
  {
    for(int i = 0; i < items.length; i++)
    {
      if(MouseInRect(items[i].rect))
      {
        draggedItem = createItemFromType(items[i].item);
        draggedIndex = i;
      }
    }
  }
  
  void onMouseRelease()
  {
    //get item thats dropped on
    for(int i = 0; i < items.length; i++)
    {
      if(MouseInRect(items[i].rect))
      {
        CombineItems(items[draggedIndex].item, items[i].item);
      } 
    }
    draggedItem = null;
    draggedIndex = -1;
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
  }
}
