trigger trgEmailMatch on Survey (before insert) {

    //extract related contact records and store them to a Map
    Map<String,String> conMap = new Map<String,String>([select email, name from contact where email != '']);

    //or
    /*
    for(Contact c : [select email, name from contact where email != '']){
        conMap.put(c.email, c.name);
    }
    */

    List<Survey> surToUpdate = new List<Survey>();

    for(Survey s : Trigger.new){
        if(String.isNotBlank(conMap.get(s.email))){
            s.Name = conMap.get(s.email);
            surToUpdate.add(s);
        }
    }

    update surToUpdate;

}