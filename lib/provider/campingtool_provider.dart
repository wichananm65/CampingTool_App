import 'package:campingtool_app/model/campingtool.dart';
import 'package:flutter/material.dart';

class CampingtoolProvider with ChangeNotifier {
  List<Campingtool> campingTools = [];

  List<Campingtool> getCampingTool() {
    return campingTools;
  }

  void addCampingTool(Campingtool newCampingTool) {
    campingTools.insert(0, newCampingTool);
    notifyListeners();
  }

  void removeCampingTool(Campingtool tool) {
    campingTools.remove(tool);
    notifyListeners();
  }
}
