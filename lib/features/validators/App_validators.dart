class AppValidators{

  static String? validateEmptyText(String? fieldName ,String? value){
    if( value==null||value.isEmpty){
      return "$fieldName is required";
    }
    return null;
  }

  static String? taskTitleValidation(String? title){
    if(title==null||title.isEmpty ){
      return 'please enter title';
    }
    return null;
  }
  static String? taskDescriptionValidation(String? description){
    if(description==null||description.isEmpty ){
      return 'please enter description';
    }
    return null;
  }
  static String? taskTimeValidation(DateTime? taskTime){
    if(taskTime==null ){
      return 'please select taskTime';
    }
    return null;
  } static String? taskDateValidation(DateTime? taskDate){
    if(taskDate==null ){
      return 'please select taskDate';
    }
    return null;
  }
}
