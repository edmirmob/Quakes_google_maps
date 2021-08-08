class TypeHelper {

 static int toInt(num value){
    try {
      if(value==null){
        return 0;
      }
      if(value is int){
        return value;
      }else{
         return value.toInt();
      }
    } catch (e) {
       print(e);
       return 0; 
    }
  }

   static double toDouble(num value){
    try {
      if(value==null){
        return 0;
      }
      if(value is double){
        return value;
      }else{
        value.toDouble();
      }
    } catch (e) {
       print(e);
       return 0; 
    }
  }
}