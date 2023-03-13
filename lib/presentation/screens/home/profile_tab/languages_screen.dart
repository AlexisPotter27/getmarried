import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/primary_button.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key, required this.onLanguagesSelected})
      : super(key: key);
  final Function(List) onLanguagesSelected;

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<String> selectedLanguages = [];
  List<String> sortedLanguages = [];
  bool showOthers = false;

  @override
  void initState() {
    super.initState();
    sortedLanguages = languages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          'Languages',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // const Text(
              //   'Looking for people who know specific languages ? Select up to 3 languages and we will try and connect you with people who know all of them ',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 13),
              // ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (val) {
                    sortLanguages(val);
                  },
                  decoration: inputDecoration(context).copyWith(
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      hintText: 'Search for a language',
                      hintStyle: const TextStyle(
                          color: Colors.black45, fontSize: 13))),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortedLanguages.length,
                  itemBuilder: (context, index) => CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: selectedLanguages.contains(sortedLanguages[index]),
                      activeColor: primaryColour,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (val) {
                        setState(() {
                          if (val!) {
                            selectedLanguages.add(languages[index]);
                          } else {
                            selectedLanguages.remove(languages[index]);
                          }
                        });
                      },
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              width: 0.5, color: Colors.grey.shade300)),
                      title: Text(sortedLanguages[index])),
                ),
              ),
              Visibility(
                  visible: selectedLanguages.isNotEmpty,
                  child: PrimaryButton(
                      child: Text('Update'),
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onLanguagesSelected(selectedLanguages);
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show other people if i run out',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: showOthers,
                        activeColor: primaryColour,
                        onChanged: (bool value) {
                          setState(() {
                            showOthers = value;
                          });
                        },
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void sortLanguages(String? query) {
    setState(() {
      if (query != null && query.isNotEmpty) {
        sortedLanguages = languages
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        sortedLanguages = languages;
      }
    });
  }
}
