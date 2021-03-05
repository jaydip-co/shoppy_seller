
const lWeight = "Weight";
const lPack = "Pack";
const lPiece = "Piece";
class LocalData {
  static Map<String,List<String>> unitType = {
    "Weight" : <String>["kg","g"],
    "Pack" : <String>["kg","g"],
    "Piece" : <String>["piece"],
  };
  static List<String> OrderState = ["pending","confirmed","Delivered","Canceled"];
}