import 'package:getmarried/widgets/reigistration/birth_date_widget.dart';

class Age{
  String? get britYear => null;


  int age(){
    int birthYear = int.parse('1');
    DateTime now =  DateTime.now();
    DateTime date = DateTime(now.year,);
    int currentYear = now.year;
    int age = currentYear - birthYear;
    return age;
  }
}