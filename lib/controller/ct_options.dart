import 'package:flutter/material.dart';

class OptionsController extends ChangeNotifier{

  static const int modelOcr = 1;
  static const int modelTesseract = 2;

  int _currModel = modelOcr;

  void switchModel(int model){
    _currModel = model;
    notifyListeners();
  }
  
  int getActiveModel(){
    return _currModel;
  }

  List<int> getListOfModels(){
    return [modelOcr, modelTesseract];
  }

  String getModelName(int model){
    switch (model) {
      case modelTesseract:
        return "Modelo Tesseract";
      default:
        return "Modelo OCR";
    }
  }

}