class ItemClass{
  final String itemID;
  final String boxID;
  final String itemName;

  ItemClass(this.itemID, this.boxID, this.itemName);

  Map<String, dynamic> toJson()=>{
    "itemID": itemID,
    "boxID": boxID,
    "itemName": itemName
  };


}